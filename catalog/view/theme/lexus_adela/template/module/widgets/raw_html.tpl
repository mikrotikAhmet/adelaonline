<?php if ( isset($raw_html) ) { ?>
<div class="widget-raw-html block panel-default <?php echo $addition_cls ?>  <?php if( isset($stylecls)&&$stylecls ) { ?>box-<?php echo $stylecls;?><?php } ?>">
	<?php if( $show_title ) { ?>
		<div class="panel-heading"><h4 class="panel-title"><?php echo $heading_title?></h4></div>
	<?php } ?>
	<div class="widget-inner block_content">
		<?php echo $raw_html; ?>
	</div>
</div>
<?php } ?>