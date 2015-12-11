<?php 
  $objlang = $this->registry->get('language');  
  $ourl = $this->registry->get('url');
?>

<div class="product-block item-full clearfix">
    <!-- image -->
    <?php if ($product['thumb']) {    ?>
    <div class="image">
      <?php if( $product['special'] ) {   ?>
        <!-- label % discount -->
        <span class="product-label sale-exist"><span class="product-label-special"><?php echo $product["discount"]; ?></span></span>
      <?php } ?>
      <div class="product-img">
        <a class="img" title="<?php echo $product['name']; ?>" href="<?php echo $product['href']; ?>">
          <img class="img-responsive" src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
        </a>
                 
        <?php if( !isset($listingConfig['catalog_mode']) || !$listingConfig['catalog_mode'] ) { ?>
          <div class="cart">            
             <button data-loading-text="Loading..." class="btn btn-cart" type="button" onclick="cart.addcart('<?php echo $product['product_id']; ?>');">
               <i class="fa fa-shopping-cart"></i><span><?php echo $button_cart; ?></span>
            </button>
          </div>
        <?php } ?>

        <div class="action add-links clearfix">
          <div class="compare">     
            <button class="btn-action" type="button" data-toggle="tooltip" data-placement="top" title="<?php echo $objlang->get("button_compare"); ?>" onclick="compare.addcompare('<?php echo $product['product_id']; ?>');"><i class="fa fa-exchange"></i></button> 
          </div>  
          <div class="wishlist">
            <button class="btn-action" type="button" data-toggle="tooltip" data-placement="top" title="<?php echo $objlang->get("button_wishlist"); ?>" onclick="wishlist.addwishlist('<?php echo $product['product_id']; ?>');"><i class="fa fa-heart"></i></button> 
          </div> 
        </div> 

      </div>
      <div id="item_countdown_<?php echo $product['product_id']; ?>" class="item-countdown"></div>     
    </div>
    <?php } ?>
  <!-- meta product -->
  <div class="product-meta">
    <div class="top">
    <h6 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h6>     
    <!-- ratting -->
    <?php if ( isset($product['rating']) ) { ?>
    <div class="rating">
      <?php for ($is = 1; $is <= 5; $is++) { ?>
        <?php if ($product['rating'] < $is) { ?>
          <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
        <?php } else { ?>
          <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i></span>
        <?php } ?>
      <?php } ?>
    </div>
    <?php } ?>
  
    <!-- price  -->
    <?php if ($product['price']) { ?>
    <div class="price">
      <?php if (!$product['special']) {  ?>
        <span class="price-new"><?php echo $product['price']; ?></span>
      <?php } else { ?>
        <span class="price-new"><?php echo $product['special']; ?></span><br>
        <span class="price-old"><?php echo $product['price']; ?></span> 
      <?php } ?>
      <?php if ($product['tax']) { ?>
        <span class="price-tax"><?php echo $objlang->get("text_tax"); ?> <?php echo $product['tax']; ?></span>
      <?php } ?>
    </div>
    <?php } ?> 

    <?php if( isset($product['description']) ){ ?> 
    <p class="description"><?php echo utf8_substr( strip_tags($product['description']),0,220);?>...</p>
    <?php } ?> 
    <div class="quickview hidden-xs hidden-xs">
      <a class="iframe-link quick-view" data-toggle="tooltip" data-placement="top" href="<?php echo $ourl->link('themecontrol/product','product_id='.$product['product_id']);?>"  title="<?php echo $objlang->get('quick_view'); ?>" ><?php echo $objlang->get('quick_view'); ?></a>
    </div> 
  </div>
  </div>  
</div>
<script type="text/javascript">
  jQuery(document).ready(function($){
  $("#item_countdown_<?php echo $product['product_id']; ?>").lofCountDown({
    formatStyle:2,
      TargetDate:"<?php echo date('m/d/Y G:i:s', strtotime($product['date_end_string'])); ?>",
      DisplayFormat:"<ul class='list-inline'><li class='days'> %%D%% <span><?php echo $objlang->get("text_days");?></span></li><li class='hours'> %%H%% <span><?php echo $objlang->get("text_hours");?></span></li><li class='minutes'> %%M%% <span><?php echo $objlang->get("text_minutes");?></span></li><li class='seconds'> %%S%% <span><?php echo $objlang->get("text_seconds");?></span></li></ul>",
      FinishMessage: "<?php echo $objlang->get('text_finish');?>"
  });
  });
</script>





