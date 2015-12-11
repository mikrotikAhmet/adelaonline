<?php  echo $header; ?>
<?php require( ThemeControlHelper::getLayoutPath( 'common/mass-header.tpl' )  ); ?>

<div class="main-columns">
 <div class="container">   
	<div class="row">
		<?php if( $SPAN[0] ): ?>
		<aside id="sidebar-left" class="col-md-<?php echo $SPAN[0];?>">
		  <?php echo $column_left; ?>
		</aside>	
	    <?php endif; ?> 
		<div id="sidebar-main" class="col-md-<?php echo $SPAN[1];?>">
		<?php require( ThemeControlHelper::getLayoutPath( 'common/mass-container.tpl' )  ); ?>
		<div class="content-inner">
		<?php echo $content_top; ?>
		<div class="block-border"><h3 class="panel-title"><?php echo $heading_title; ?></h3></div>
		<!-- Start Div Content -->
		<div class="pav-filter-blogs blog-wrapper">
			<div class="pav-blogs">
				<?php $cols = $cat_columns_leading_blogs;

				if( count($leading_blogs) ) { ?>
					<div class="leading-blogs blog-list-item">
						<div class="row">
						<?php foreach( $leading_blogs as $key => $blog ) { $key = $key + 1;?>
						<div class="pavcol<?php echo $cols;?>">
						<?php require( '_item.tpl' ); ?>
						</div>
						<?php if( ( $key%$cols==0 || $cols == count($leading_blogs)) ){ ?>
							<div class="clearfix"></div>
						<?php } ?>
						<?php } ?>
						</div>
					</div>
				<?php } ?>

				<?php
					$cols = $cat_columns_secondary_blogs;
					$cols = !empty($cols)?$cols:1;
					if ( count($secondary_blogs) ) { ?>
					<div class="secondary blog-list-item">
						<div class="row">	
						<?php foreach( $secondary_blogs as $key => $blog ) {  $key = $key+1; ?>
						<div class="pavcol<?php echo $cols;?>">
						<?php require( '_item.tpl' ); ?>
						</div>
						<?php if( ( $key%$cols==0 || $cols == count($leading_blogs)) ){ ?>
							<div class="clearfix"></div>
						<?php } ?>
						<?php } ?>
						</div>
					</div>
				<?php } ?>
					
				<div class="pav-pagination pagination"><?php echo $pagination;?></div>
			</div>
		</div>
		<!-- End Div Content -->
		<?php echo $content_bottom; ?></div>
	</div>
		<!-- End Div Row -->
		<?php if( $SPAN[2] ): ?>
		<aside id="sidebar-right" class="col-md-<?php echo $SPAN[2];?>">	
		<?php echo $column_right; ?>
		</aside>
	<?php endif; ?>
	</div>
</div>
</div><!-- End Div Container -->
<?php echo $footer; ?>