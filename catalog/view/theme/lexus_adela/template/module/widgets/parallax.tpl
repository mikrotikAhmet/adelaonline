<div class="parallax parallax-<?php if($parallaxtype == 'image'){echo 'img-v';}else{echo 'color-v';};?> <?php echo $addition_cls;?> parallax-light panel-default">
    <div class="parallax-heading">
    	<?php if($iconclass){?>
        <p class="parallax-icon">
        	<i class="fa <?php echo $iconclass?>"></i>
	        <?php }elseif($iconurl && $iconfile){?>
	        	<img src="<?php echo $iconurl;?>" alt="<?php echo $heading_title?>"/>
            </p>
	        <?php }?>
        <?php if($show_title){?><h2><?php echo $heading_title;?></h2><?php }?>
        <?php echo $content_html;?>
    </div>
</div>