<div data-toggle="dropdown" data-loading-text="<?php echo $text_loading; ?>" class="heading dropdown-toggle">   
<div class="cart-inner pull-right">
  <a class="btn">
    <i class="cart-icon fa fa-shopping-cart"></i>
     <?php 
     	$tmp = preg_split("#-#", $text_items );
     	if( count($tmp) > 1 ){
     		$text_items = $tmp[0];
     	}
     ?>
     <span id="cart-total" class="cart-total cart-mini-info"><?php echo $text_items;?></span>
  </a>
</div>
</div>