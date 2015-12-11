<?php
	$config = $this->registry->get('config');
	$theme  = $config->get('config_template');
	$cols = isset($customcols)? $customcols : 3;
	$span = 12/$cols;
					$themeConfig  	 			= (array)$config->get('themecontrol');
						$listingConfig  			= array(
				'category_pzoom' 		=> 1,
				'show_swap_image' 		=> 0,
					'quickview' 			=> 0,
				'product_layout'		=> 'default',
					'catalog_mode'			=> '',
	);
				$listingConfig  			= array_merge($listingConfig, $themeConfig );
				$categoryPzoom 	    		= $listingConfig['category_pzoom'];
						$quickview 					= $listingConfig['quickview'];
						$swapimg 					= ($listingConfig['show_swap_image'])?'swap':'';

	if( isset($_COOKIE[$theme.'_productlayout']) && $listingConfig['enable_paneltool'] && $_COOKIE[$theme.'_productlayout'] ){
		$listingConfig['product_layout'] = trim($_COOKIE[$theme.'_productlayout']);
	}
	
	$productLayout = DIR_TEMPLATE.$theme.'/template/common/product/'.$listingConfig['product_layout'].'.tpl';
	if( !is_file($productLayout) ){
		$listingConfig['product_layout'] = 'default';
	}
    $productLayout = DIR_TEMPLATE.$config->get('config_template').'/template/common/product/'.$listingConfig['product_layout'].'.tpl'; 
	$ourl = $this->registry->get('url');
	$id = md5(rand()+time()+$heading_title); 
?>
<div class="panel-heading highlight">
	<h3 class="panel-title"><?php echo $heading_title; ?></h3>
</div>
<div class="products-owl-carousel over-hidden" id="wrap<?php echo $id; ?>">
	<div class="products-block products-owl" id="<?php echo $id; ?>">
		<?php foreach ($products as $i => $product) { $i=$i+1; ?>
			<div class="product-col-wrap products-row"><div class="product-col">
				<?php require( $productLayout );  ?>
			</div></div>
		<?php } ?>
	</div>
	 <!-- Controls -->
    <?php
    if(count($products)>$cols){
    ?>
    <div class="carousel-controls hidden-xs hidden-sm">
        <a class="carousel-control left" href="#image-additional" data-slide="next">
            <i class="fa fa-angle-left"></i>
        </a>
        <a class="carousel-control right" href="#image-additional" data-slide="prev">
            <i class="fa fa-angle-right"></i>
        </a>
    </div>
    <?php } ?>

</div>
 <script type="text/javascript">
	$(document).ready(function() {
	   var $carousel =  $("#<?php echo $id; ?>"); 
	   $carousel.owlCarousel({
	        autoPlay: false, //Set AutoPlay to 3 seconds
	        items : <?php echo $cols; ?>,
	        lazyLoad : true,
			navigation: false,
			navigationText:false,
			rewindNav: false,
			pagination:false
 
	    }); 
	    $("#wrap<?php echo $id; ?> .carousel-control.left").click(function(){
	         $carousel.trigger('owl.prev');
	    })
	   $("#wrap<?php echo $id; ?> .carousel-control.right").click(function(){
	        $carousel.trigger('owl.next');
	    })
	});
</script>