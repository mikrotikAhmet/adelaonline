<?php

 /**
 * Sentir Development
 *
 * @category   adelaonline
 * @package    Payment Gateway
 * @copyright  Copyright 2014-2015 Sentir Development
 * @license    http://www.sentir-development.com/license/
 * @version    1.0.15.10
 * @author     Ahmet GOUDENOGLU <ahmet.gudenoglu@sentir-development.com>
 */

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$start = microtime(true);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

require_once '../config.php';
require_once DIR_SYSTEM . 'startup.php';


// Check Package
if (is_array($argv) && isset($argv[1])) {

    $packFile = $argv[1];

    $package = json_decode(file_get_contents(DIR_SYSTEM.'storage/upload/' . $packFile));

} else {

    throw new Exception ('Application Package file could not be found!');
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Custom
require_once 'library/curl.php';
require_once 'library/extractor.php';

// Registry
$registry = new Registry();

// Database
$db = new DB(DB_DRIVER, DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE);
$registry->set('db', $db);

// DOMDocument object
$dom = new DOMDocument ();
$registry->set('dom',$dom);

$e = new Extractor();
$registry->set('extractor',$e);

$find = array(
    ' 2015',
    '...',
    '&'
);

$replace = array(
    '',
    '',
    '&amp;'
);

$Markup = 0;

foreach ($package->ProductsObj as $product){

    // MAIN PRODUCT PAGE URL
    $page = $e->get_page( $product->external_url );

    // Initiate DomDocument
    $dom    = new DOMDocument ();
    @$dom->loadHTML ( $page );
    $xpath  = new DOMXPath ( $dom );


    $Title = @$xpath->query ( '//div[@class="widget prod-info-title"]/h1' );
    $Price = @$xpath->query ( '//strong[@itemprop="price"]' );
    $ColorOption = @$xpath->query ( '//select[@name="id[153]"]/option' );
    $SizeOption = @$xpath->query ( '//select[@name="id[39]"]/option' );
    $TSSizeOption = @$xpath->query ( '//select[@name="id[590]"]/option' );
    $BraSizeOption = @$xpath->query ( '//select[@name="id[537]"]/option' );
    $DescriptionTitle = @$xpath->query ( '//th[@class="strong-title"]' );
    $DescriptionValue = @$xpath->query ( '//td[@class="inline"]' );
    $ProductPictures = @$xpath->query ( '//div[@class="viewport"]/ul/li/a/img/@src' );


    $Pictures = array();
    if (!$ProductPictures->length){
        $ProductPictures = @$xpath->query ( '//div[@class="viewport"]/div/div/img/@src' );
    }

    for ($Count = 0; $Count <= $ProductPictures->length - 1; $Count++) {

        $Pictures[] = array(
            'image'=>importImage($product->product_category,str_replace('50x50','384x384',$ProductPictures->item($Count)->nodeValue)),
            'sort_order'=>$Count
        );
    }

    $TitleTrim = explode('#',$Title->item(0)->nodeValue);

    $productTitle = stripAlpha($TitleTrim[0]);
    $ProductSKU = $TitleTrim[1];
    $ProductPrice = stripAlpha(str_replace('$','',$Price->item(0)->nodeValue));


    $Specifications=array();
    for ($Count = 0; $Count <= $DescriptionTitle->length - 1; $Count++) {

        $Specifications[$DescriptionTitle->item($Count)->nodeValue] = $DescriptionValue->item($Count)->nodeValue;
    }


    $price = markupCost($ProductPrice, $Markup);

    $data = array(
        'product_description'=>array(
            '1'=>array(
                'name'=>$productTitle,
                'description'=>createDescription($Specifications),
                'meta_title'=>$productTitle,
                'meta_description'=>$productTitle,
                'meta_keyword'=>null,
                'tag'=>null
            )
        ),
        'product_store'=>array(
            0
        ),
        'model'=>stripAlpha($ProductSKU),
        'sku'=>stripAlpha($ProductSKU),
        'quantity'=>99999,

        'stock_status_id'=>7,
        'price'=>$price,
        'image'=>$Pictures[0]['image'],
        'status'=>1,
        'product_category'=>array(
            $product->product_category
        ),
        'product_image'=>$Pictures,
    );

    if ($data && !checkProductByModel($ProductSKU,$ProductSKU)){
        addProduct($data);
    } else {
        updateProduct($data,$ProductSKU);
    }

    repairProducts();

}

function repairProducts(){

    global $db;

    $results = $db->query("SELECT * FROM ".DB_PREFIX."product WHERE DATEDIFF(CURDATE(), date_modified) > 7");

    foreach ($results->rows as $result){

        $db->query("UPDATE ".DB_PREFIX."product SET status = '0' WHERE product_id = '".(int) $result['product_id']."'");
    }
}

function addProduct($data=array()){

    global $db;

    $db->query("INSERT INTO " . DB_PREFIX . "product SET model = '" . $db->escape($data['model']) . "',
        sku = '" . (float)$data['sku'] . "',
        price = '" . (float)$data['price'] . "',
        quantity = '" . (int)$data['quantity'] . "',
        status = '" . (int)$data['status'] . "',
        date_available = NOW(),
        subtract = '0',
        stock_status_id = '" . (int)$data['stock_status_id'] . "',
        date_modified = NOW(),
        date_added = NOW()");

    $product_id = $db->getLastId();



    if (isset($data['image'])) {
        $db->query("UPDATE " . DB_PREFIX . "product SET image = '" . $db->escape($data['image']) . "' WHERE product_id = '" . (int)$product_id . "'");
    }


    foreach ($data['product_description'] as $language_id=>$value) {
        $db->query("INSERT INTO " . DB_PREFIX . "product_description SET product_id = '" . (int)$product_id . "', language_id = '" . (int)$language_id . "', name = '" . $db->escape($value['name']) . "', description = '" . $db->escape($value['description']) . "', tag = '" . $db->escape($value['tag']) . "', meta_title = '" . $db->escape($value['meta_title']) . "', meta_description = '" . $db->escape($value['meta_description']) . "', meta_keyword = '" . $db->escape($value['meta_keyword']) . "'");
    }


    if (isset($data['product_store'])) {
        foreach ($data['product_store'] as $store_id) {
            $db->query("INSERT INTO " . DB_PREFIX . "product_to_store SET product_id = '" . (int)$product_id . "', store_id = '" . (int)$store_id . "'");
        }
    }

    if (isset($data['product_image'])) {
        foreach ($data['product_image'] as $product_image) {
            $db->query("INSERT INTO " . DB_PREFIX . "product_image SET product_id = '" . (int)$product_id . "', image = '" . $db->escape($product_image['image']) . "', sort_order = '" . (int)$product_image['sort_order'] . "'");
        }
    }

    if (isset($data['product_category'])) {
        foreach ($data['product_category'] as $category_id) {
            $db->query("INSERT INTO " . DB_PREFIX . "product_to_category SET product_id = '" . (int)$product_id . "', category_id = '" . (int)$category_id . "'");
        }
    }
}

function updateProduct($data=array(),$model){

    global $db;

    $db->query("UPDATE " . DB_PREFIX . "product SET
        price = '" . (float)$data['price'] . "',
        date_modified = NOW() WHERE model = '".$db->escape($model)."'");

    if (isset($data['product_category'])) {
        foreach ($data['product_category'] as $category_id) {
            $db->query("INSERT INTO " . DB_PREFIX . "product_to_category SET model = '" . (int)$model . "', category_id = '" . (int)$category_id . "'");
        }
    }
}


function checkProductByModel($model,$sku){

    global $db;

    $result = $db->query("SELECT * FROM ".DB_PREFIX."product WHERE model = '".$db->escape($model)."' OR sku = '".(int)$sku."'");

    if ($result->row){
        return true;
    } else {
        return false;
    }
}

function importImage($folder,$imageUrl,$extension='jpg'){

    $targetDir = DIR_IMAGE . 'catalog/sentir/' . $folder;

    if (!is_dir($targetDir)){
        mkdir(DIR_IMAGE . 'catalog/sentir/' . $folder, 0777);
    }

    $base = basename($imageUrl, '.'.$extension);

    if (!file_exists($targetDir.'/'. $base . ".".$extension)){

        copy($imageUrl, $targetDir.'/'. $base . ".".$extension);

        return 'catalog/sentir/' .$folder.'/'. $base . ".".$extension;

    } else {
        return 'catalog/sentir/' . $folder.'/'.$base . ".".$extension;
    }
}

// Clean up the strings
function stripAlpha( $item )

{

    $search     = array(
        '@<script[^>]*?>.*?</script>@si'   // Strip out javascript
    ,'@<style[^>]*?>.*?</style>@siU'    // Strip style tags properly
    ,'@<[\/\!]*?[^<>]*?>@si'            // Strip out HTML tags
    ,'@<![\s\S]*?–[ \t\n\r]*>@'         // Strip multi-line comments including CDATA
    ,'/\s{2,}/'
    ,'/(\s){2,}/'
    );

    $pattern    = array(
        '/\s+/'                            // More than one whitespace
    );

    $replace    = array(
        ' '

    );

    $item = preg_replace( $search, '', html_entity_decode( $item ) );
    $item = trim( preg_replace( $pattern, $replace, strip_tags( $item ) ) );
    return $item;

}

function markupCost($price, $markup){


    $markupPrice =  ($price * $markup) / 100;

    $adPrice = $price + $markupPrice;

    return $adPrice;
}

function createDescription($array){

    $openTag = '<dl class="">';
    $closetag = '</dl>';
    $out = '';
    foreach ($array as $key=>$spec){

        $out .='<dt style="float: left; width: 250px;">'.$key.'</dt>';
        $out .='<dd style="margin-left: 100px;">'.$spec.'</dd>';

    }

    return $openTag.$out.$closetag;


}

 /* End of file sentir.php */  