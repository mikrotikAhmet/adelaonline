<?php $objlang = $this->registry->get('language'); ?>
<?php if ($thumb || $images) { ?>
<div class="col-xs-12 col-sm-<?php echo $cols[0]; ?> col-md-<?php echo $cols[0]; ?> col-lg-<?php echo $cols[0]; ?> image-container">    
    <?php if ($thumb) { ?>
    <div class="image">

        <?php if( isset($date_available) && $date_available == date('Y-m-d')) {   ?>            
        <span class="product-label product-label-new">
            <span><?php echo 'New'; ?></span>  
        </span>                                             
        <?php } ?>  
        <?php if( $special )  { ?>          
            <span class="product-label sale-exist"><span class="product-label-special"><?php echo $objlang->get( 'text_sale' ); ?></span></span>
        <?php } ?>

        <a href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" class="imagezoom">
            <img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" id="image"  data-zoom-image="<?php echo $popup; ?>" class="product-image-zoom img-responsive"/>
        </a>
    </div>
    <?php } ?>  
     <div class="thumbs-preview horizontal">
        <?php if ($images) { ?>
         <div class="image-additional olw-carousel horical" id="image-additional">
            <div id="image-additional-carousel">
                <?php 
                if( $productConfig['product_zoomgallery'] == 'slider' && $thumb ) {  
                    $eimages = array( 0=> array( 'popup'=>$popup,'thumb'=> $thumb )  ); 
                    $images = array_merge( $eimages, $images );
                }
                $icols = 5; $i= 0;
                foreach ($images as  $image) { ?>
                    <div class="item clearfix">
                        <a href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" class="imagezoom" data-zoom-image="<?php echo $image['popup']; ?>" data-image="<?php echo $image['popup']; ?>">
                            <img src="<?php echo $image['thumb']; ?>" style="max-width:<?php echo $config->get('config_image_additional_width');?>px"  title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" data-zoom-image="<?php echo $image['popup']; ?>" class="product-image-zoom img-responsive" />
                        </a>
                    </div>
                <?php } ?>      
            </div>

                <script type="text/javascript">
                    $(document).ready(function() {
                       var $carousel =  $("#image-additional-carousel"); 
                       $carousel.owlCarousel({
                            autoPlay: false, //Set AutoPlay to 3 seconds
                            items : <?php echo $icols; ?>,
                            pagination:false
                        }); 
                        $("#image-additional .carousel-control.left").click(function(){
                             $carousel.trigger('owl.prev');
                        })
                       $("#image-additional .carousel-control.right").click(function(){
                            $carousel.trigger('owl.next');
                        })
                    });
                </script>

            <!-- Controls -->
            <?php
            if(count($images)>$icols){
            ?>
            <!-- <div class="carousel-controls"> -->
                <a class="carousel-control left carousel-sm" href="#image-additional" data-slide="next">
                    <i class="fa fa-angle-left"></i>
                </a>
                <a class="carousel-control right carousel-sm" href="#image-additional" data-slide="prev">
                    <i class="fa fa-angle-right"></i>
                </a>
            <!-- </div> -->
            <?php } ?>
        </div>          
        <script type="text/javascript">
            $('#image-additional .item:first').addClass('active');
            $('#image-additional').carousel({interval:false})
        </script>
        <?php } ?> 
    </div>    
</div>          
<?php } ?>

