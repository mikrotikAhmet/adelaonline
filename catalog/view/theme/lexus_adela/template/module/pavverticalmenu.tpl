<?php
  $this->language( 'module/themecontrol' );
  $objlang = $this->registry->get('language');
?>
<div class="menu-heading hidden-xs hidden-sm">
	<h4>
	  <span class="fa fa-bars pull-right"></span>
	  <?php echo $objlang->get('text_catalog_menu'); ?>              
	</h4>
</div>
<div class="pav-verticalmenu hidden-xs hidden-sm">
	<div class="navbar navbar-default">
		<div id="mainmenutop" class="verticalmenu" role="navigation">
			<div class="navbar-header">
			<a href="javascript:void(0);" data-target=".navbar-collapse" data-toggle="collapse" class="navbar-toggle">
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		     </a>
			<div class="collapse navbar-collapse navbar-ex1-collapse">
			<?php echo $treemenu; ?>
			 </div></div>
		</div>
	</div>
</div>