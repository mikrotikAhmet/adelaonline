<?php
/**
 * Created by PhpStorm.
 * User: root
 * Date: 12/2/15
 * Time: 3:20 PM
 */

class ModelFeedSentirDropship extends Model {
    public function install() {
        $this->db->query("
			CREATE TABLE `" . DB_PREFIX . "sentir_dropship_category` (
				`sentir_dropship_category_id` INT(11) NOT NULL AUTO_INCREMENT,
				`name` varchar(255) NOT NULL,
				PRIMARY KEY (`sentir_dropship_category_id`)
			) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
		");

        $this->db->query("
			CREATE TABLE `" . DB_PREFIX . "sentir_dropship_category_to_category` (
				`sentir_dropship_category_id` INT(11) NOT NULL,
				`category_id` INT(11) NOT NULL,
				PRIMARY KEY (`sentir_dropship_category_id`, `category_id`)
			) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
		");

        $this->db->query("
			CREATE TABLE `" . DB_PREFIX . "sentir_dropship_inventory` (
				`product_id` INT(11) NOT NULL,
				`category_id` INT(11) NOT NULL,
				PRIMARY KEY (`product_id`)
			) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
		");

        mkdir(DIR_IMAGE . '/catalog/sentir', 0755);
        chmod(DIR_IMAGE . '/catalog/sentir', 0755);
//        chown(DIR_IMAGE . '/catalog/sentir','www-data:www-data');
    }

    public function uninstall() {
        $this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "sentir_dropship_category`");
        $this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "sentir_dropship_category_to_category`");
        $this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "sentir_dropship_inventory`");
    }

    public function import($data) {
        $this->db->query("DELETE FROM " . DB_PREFIX . "sentir_dropship_category");

        foreach ($data as $category_id=>$name){
            $this->db->query("INSERT INTO " . DB_PREFIX . "sentir_dropship_category SET sentir_dropship_category_id = '" . (int)$category_id . "', name = '" . $this->db->escape($name) . "'");
        }
    }

    public function updateInventoryUrl($url,$id){

        $this->db->query("UPDATE ".DB_PREFIX."sentir_dropship_inventory SET productUrl = '".$this->db->escape($url)."' WHERE product_id = '".(int) $id."'");
    }

    public function getSentirDropshipCategories($data = array()) {
        $sql = "SELECT * FROM `" . DB_PREFIX . "sentir_dropship_category` WHERE name LIKE '%" . $this->db->escape($data['filter_name']) . "%' ORDER BY name ASC";

        if (isset($data['start']) || isset($data['limit'])) {
            if ($data['start'] < 0) {
                $data['start'] = 0;
            }

            if ($data['limit'] < 1) {
                $data['limit'] = 20;
            }

            $sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
        }

        $query = $this->db->query($sql);

        return $query->rows;
    }

    public function addCategory($data) {
        $this->db->query("DELETE FROM " . DB_PREFIX . "sentir_dropship_category_to_category WHERE category_id = '" . (int)$data['category_id'] . "'");

        $this->db->query("INSERT INTO " . DB_PREFIX . "sentir_dropship_category_to_category SET sentir_dropship_category_id = '" . (int)$data['sentir_dropship_category_id'] . "', category_id = '" . (int)$data['category_id'] . "'");
    }

    public function deleteCategory($category_id) {
        $this->db->query("DELETE FROM " . DB_PREFIX . "sentir_dropship_category_to_category WHERE category_id = '" . (int)$category_id . "'");
    }

    public function getLocalCategories($data = array()) {
        $sql = "SELECT sentir_dropship_category_id, name  FROM ".DB_PREFIX."sentir_dropship_category";

        if (isset($data['start']) || isset($data['limit'])) {
            if ($data['start'] < 0) {
                $data['start'] = 0;
            }

            if ($data['limit'] < 1) {
                $data['limit'] = 20;
            }

            $sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
        }

        $query = $this->db->query($sql);

        return $query->rows;
    }

    public function getCategories($data = array()) {
        $sql = "SELECT sentir_dropship_category_id, (SELECT name FROM `" . DB_PREFIX . "sentir_dropship_category` gbc WHERE gbc.sentir_dropship_category_id = gbc2c.sentir_dropship_category_id) AS sentir_dropship_category, category_id, (SELECT name FROM `" . DB_PREFIX . "category_description` cd WHERE cd.category_id = gbc2c.category_id AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "') AS category FROM `" . DB_PREFIX . "sentir_dropship_category_to_category` gbc2c ORDER BY sentir_dropship_category ASC";

        if (isset($data['start']) || isset($data['limit'])) {
            if ($data['start'] < 0) {
                $data['start'] = 0;
            }

            if ($data['limit'] < 1) {
                $data['limit'] = 20;
            }

            $sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
        }

        $query = $this->db->query($sql);

        return $query->rows;
    }

    public function removeInventory($product_id){

        $this->db->query("DELETE FROM  ".DB_PREFIX."sentir_dropship_inventory WHERE product_id = '".(int) $product_id."'");

    }

    public function getLocalCategoryBySourceCategoryId($sourceCategoryId){
        $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "sentir_dropship_category_to_category` WHERE sentir_dropship_category_id = '".(int) $sourceCategoryId."'");

        return $query->row['category_id'];

    }

    public function setInventory($products,$type,$category_id){

        $data = explode(',',$products);

        if ($type == 'add'){
            foreach($data as $product_id){

                $result = $this->db->query("SELECT * FROM ".DB_PREFIX."sentir_dropship_inventory WHERE product_id='".(int) $product_id."'");

                if ($product_id && $product_id > 0 && !$result->row){
                    $this->db->query("INSERT INTO ".DB_PREFIX."sentir_dropship_inventory SET product_id = '".(int) $product_id."', category_id = '".(int) $category_id."'");
                }
            }
        } elseif ($type == 'remove') {
            foreach($data as $product_id){
                if ($product_id){
                    $this->db->query("DELETE FROM  ".DB_PREFIX."sentir_dropship_inventory WHERE product_id = '".(int) $product_id."'");
                }
            }
        }

    }

    public function importData($data) {

       /////////////////////////////////////////
        //Markup is Here
        $markupPrice = ($data->map * 1) / 100;

        $price = $data->map + $markupPrice;
        //////////////////////////////////////////

        $check = $this->checkProduct($data->model);

        if (!$check) {

            $this->event->trigger('pre.admin.product.add', $data);

            $this->db->query("INSERT INTO " . DB_PREFIX . "product SET model = '" . $this->db->escape($data->model) . "',
        sku = '" . $this->db->escape($data->sku) . "',
        upc = '" . $this->db->escape($data->upc) . "',
        ean = '" . $this->db->escape($data->ean) . "',
        jan = '" . $this->db->escape($data->jan) . "',
        isbn = '" . $this->db->escape($data->isbn) . "',
        mpn = '" . $this->db->escape($data->mpn) . "',
        quantity = '" . (int)$data->quantity . "',
        minimum = '" . (int)$data->minimum . "',
        date_available = '" . $this->db->escape($data->date_available) . "',
        price = '" . (float)$price . "',
        status = '" . (int)$data->status . "',
        date_added = NOW()");

            $product_id = $this->db->getLastId();

            if (isset($data->product_images)) {

                if (!empty($data->product_images->image)) {

                    $base = basename($data->product_images->image, '.jpg');

                    if (!file_exists(DIR_IMAGE . 'catalog/sentir/' . $base . '.jpg')) {

                        copy($data->product_images->image, DIR_IMAGE . 'catalog/sentir/' . $base . '.jpg');
                        $image = 'catalog/sentir/' . $base . '.jpg';
                    } else {
                        $image = 'catalog/sentir/' . $base . '.jpg';
                    }
                }

             $this->db->query("UPDATE " . DB_PREFIX . "product SET image = '" . $this->db->escape($image) . "' WHERE product_id = '" . (int)$product_id . "'");
            }

            foreach ($data->product_description as $language_id => $value) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_description SET product_id = '" . (int)$product_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value->name) . "', description = '" . $this->db->escape(htmlspecialchars($value->description)) . "', tag = '" . $this->db->escape($value->tag) . "', meta_title = '" . $this->db->escape($value->meta_title) . "', meta_description = '" . $this->db->escape($value->meta_description) . "', meta_keyword = '" . $this->db->escape($value->meta_keyword) . "'");
            }

            $this->db->query("INSERT INTO " . DB_PREFIX . "product_to_store SET product_id = '" . (int)$product_id . "', store_id = '0'");


            $this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'product_id=" . (int)$product_id . "', keyword = '" . $this->db->escape($data->model) . "'");

        if (isset($data->product_option)) {
            foreach ($data->product_option as $product_option) {

                if ($product_option->type == 'select' || $product_option->type == 'radio' || $product_option->type == 'checkbox' || $product_option->type == 'image') {
                    if (isset($product_option->product_option_value)) {
                        $this->db->query("INSERT INTO " . DB_PREFIX . "product_option SET product_id = '" . (int)$product_id . "', option_id = '" . (int)$this->checkOptionByName($product_option->type,$product_option->name) . "', required = '" . (int)$product_option->required . "'");

                        $product_option_id = $this->db->getLastId();

                        foreach ($product_option->product_option_value as $product_option_value) {
                            $this->db->query("INSERT INTO " . DB_PREFIX . "product_option_value SET product_option_id = '" . (int)$product_option_id . "', product_id = '" . (int)$product_id . "', option_id = '" . (int)$this->checkOptionByName($product_option->type,$product_option->name). "', option_value_id = '" . (int)$this->checkOptionValueByName($this->checkOptionByName($product_option->type,$product_option->name),$product_option_value->name) . "', quantity = '" . (int)$product_option_value->quantity . "', subtract = '" . (int)$product_option_value->subtract . "', price = '" . (float)$product_option_value->price . "', price_prefix = '" . $this->db->escape($product_option_value->price_prefix) . "', points = '" . (int)$product_option_value->points . "', points_prefix = '" . $this->db->escape($product_option_value->points_prefix) . "', weight = '" . (float)$product_option_value->weight . "', weight_prefix = '" . $this->db->escape($product_option_value->weight_prefix) . "'");
                        }
                    }
                } else {
                    $this->db->query("INSERT INTO " . DB_PREFIX . "product_option SET product_id = '" . (int)$product_id . "', option_id = '" . (int)$this->checkOptionByName($product_option->type,$product_option->name) . "', value = '" . $this->db->escape($product_option->value) . "', required = '" . (int)$product_option->required . "'");
                }
            }
        }

        if (isset($data->product_images->images)) {
            foreach ($data->product_images->images as $product_image) {

                $base = basename($product_image->image, '.jpg');

                copy($product_image->image, DIR_IMAGE . 'catalog/sentir/' . $base . '.jpg');

                $imagename = 'catalog/sentir/' . $base . '.jpg';

                $this->db->query("INSERT INTO " . DB_PREFIX . "product_image SET product_id = '" . (int)$product_id . "', image = '" . $this->db->escape($imagename) . "', sort_order = '" . (int)$product_image->sort_order . "'");
            }
        }

            if (isset($data->product_category)) {
                foreach ($data->product_category as $category_id) {
                    $this->db->query("INSERT INTO " . DB_PREFIX . "product_to_category SET product_id = '" . (int)$product_id . "', category_id = '" . (int)$category_id . "'");
                }
            }


            $this->cache->delete('product');

            $this->event->trigger('post.admin.product.add', $product_id);

            return $product_id;
        }
    }

//    public function importXML($xml){
//
//        $xml_data = simplexml_load_string($xml, "SimpleXMLElement", LIBXML_NOCDATA);
//        $json = json_encode($xml_data);
//        $array = json_decode($json,TRUE);
//
//        print_r($array);
//    }

    public function checkOptionByName($optionType,$optionName){

        $result =  $this->db->query("SELECT * FROM ".DB_PREFIX."option_description WHERE name = '".$this->db->escape($optionName)."'");

        if ($result->row){
            return $result->row['option_id'];
        } else {
            $this->db->query("INSERT INTO ".DB_PREFIX."option SET type='".$this->db->escape($optionType)."'");


            $option_id = $this->db->getLastId();

            $this->db->query("INSERT INTO ".DB_PREFIX."option_description SET language_id='".$this->db->escape($this->config->get('config_language_id'))."',option_id = '".(int)$option_id."',name='".$this->db->escape($optionName)."'");

            return $option_id;
        }
    }

    public function checkOptionValueByName($optionId,$optionValueName){

        $result =  $this->db->query("SELECT * FROM ".DB_PREFIX."option_value_description WHERE name = '".$this->db->escape($optionValueName)."' AND option_id = '".(int) $optionId."'");

        if ($result->row){
            return $result->row['option_value_id'];
        } else {
            $this->db->query("INSERT INTO ".DB_PREFIX."option_value SET option_id='".(int)$optionId."'");


            $option_value_id = $this->db->getLastId();

            $this->db->query("INSERT INTO ".DB_PREFIX."option_value_description SET option_value_id = '".(int) $option_value_id."',language_id='".$this->db->escape($this->config->get('config_language_id'))."',option_id = '".(int)$optionId."',name='".$this->db->escape($optionValueName)."'");

            return $option_value_id;
        }
    }

    public function checkProduct($model){

        $result = $this->db->query("SELECT * FROM ".DB_PREFIX."product WHERE model = '".$this->db->escape($model)."'");

        return $result->row;

    }

    public function getCollection(){

        $collection_data = array();

        $query = $this->db->query("SELECT * FROM ".DB_PREFIX."sentir_dropship_inventory");

        foreach ($query->rows as $ids){
            $collection_data[$ids['category_id']][] = $ids['product_id'];
        }


        return json_encode($collection_data);

    }

    public function getInventory($data=array()){

        $sql = "SELECT * FROM ".DB_PREFIX."sentir_dropship_inventory";

        if (isset($data['start']) || isset($data['limit'])) {
            if ($data['start'] < 0) {
                $data['start'] = 0;
            }

            if ($data['limit'] < 1) {
                $data['limit'] = 20;
            }

            $sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
        }

        $query = $this->db->query($sql);

        foreach ($query->rows as $product){
            $selected[] = $product['product_id'];
        }

        if ($query->rows){
            return $selected;
        } else {
            return array();
        }

    }

    public function getTotalLocalCategories() {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "sentir_dropship_category`");

        return $query->row['total'];
    }

    public function getTotalCategories() {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "sentir_dropship_category_to_category`");

        return $query->row['total'];
    }
}
