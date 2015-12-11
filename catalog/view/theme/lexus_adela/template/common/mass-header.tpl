<?php require( PAVO_THEME_DIR."/template/common/config_layout.tpl" );  ?>
<div class="breadcrumbs">
    <div class="container">  
    <div class="container-inner">   
        <?php $tmp = $breadcrumbs;  $end = array_slice($tmp , count($tmp)-1 ); ?>
        <?php if( isset($breadcrumbs) ) { ?>
			 <ul class="list-unstyled breadcrumb-links">
			<?php foreach ($breadcrumbs as $breadcrumb) { ?>
			<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
			<?php } ?>
			</ul>
		<?php } ?>
	</div>
    </div>
</div>