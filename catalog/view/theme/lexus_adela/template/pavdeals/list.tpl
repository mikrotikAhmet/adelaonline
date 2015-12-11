<?php 
	$config = $this->registry->get('config'); 

	$theme  = $config->get('config_template');

	$productLayout = DIR_TEMPLATE.$config->get('config_template').'/template/common/deal_collection.tpl';	 

?>
<?php $objlang = $this->registry->get('language');  $ourl = $this->registry->get('url');   ?>
<?php echo $header; ?>
<?php require( ThemeControlHelper::getLayoutPath( 'common/mass-header.tpl' )  ); ?>
<div class="main-columns space-30">
	 <div class="container">   
<div class="row">
	<?php if( $SPAN[0] ): ?>
		<aside id="sidebar-left" class="col-md-<?php echo $SPAN[0];?>">
			<?php echo $column_left; ?>
		</aside>	
	<?php endif; ?>
	<div id="sidebar-main" class="col-md-<?php echo $SPAN[1];?>">
		<div id="content"><?php echo $content_top; ?>
			<div class="deals">
	            <div class="tab-v4 text-center">
					<ul class="nav nav-tabs">
						<?php foreach ($head_titles as $item): ?>
						<?php if ($item['active']): ?>
						<li class="active"><a href="<?php echo $item['href'];?>"><?php echo $item['text'];?></a></li>
						<?php else: ?>
						<li><a href="<?php echo $item['href'];?>"><?php echo $item['text'];?></a></li>
						<?php endif; ?>
						<?php endforeach; ?>
					</ul>
	            </div>
				<!-- Deal Option -->	
				<!-- Fillter Product -->
				<?php if (count($products) > 0): ?>

				<div class="product-filter clearfix">
					<div class="display">
						<div class="group-switch hidden-xs hidden-sm">
					      <button type="button" id="list-view" class="btn btn-switch" data-toggle="tooltip" title="<?php echo $objlang->get("button_list"); ?>"><i class="fa fa-th-list"></i></button>
					      <button type="button" id="grid-view" class="btn btn-switch active" data-toggle="tooltip" title="<?php echo $objlang->get("button_grid"); ?>"><i class="fa fa-th"></i></button>
					    </div>
					</div>
					<div class="filter-right">
						<div class="category pull-right">
							<span for="input-category"><?php echo $objlang->get('text_category'); ?></span>
							<select id="input-category" class="form-control" name="category_id" onchange="location = this.value;">
								<option value="<?php echo $href_default;?>"><?php echo $objlang->get("text_category_all"); ?></option>
								<?php foreach ($categories as $category_1) { ?>
								<?php if ($category_1['category_id'] == $category_id) { ?>
								<option value="<?php echo $category_1['href']; ?>" selected="selected"><?php echo $category_1['name']; ?></option>
								<?php } else { ?>
								<option value="<?php echo $category_1['href']; ?>"><?php echo $category_1['name']; ?></option>
								<?php } ?>
								<?php foreach ($category_1['children'] as $category_2) { ?>
								<?php if ($category_2['child_id'] == $category_id) { ?>
								<option value="<?php echo $category_2['href']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
								<?php } else { ?>
								<option value="<?php echo $category_2['href']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
								<?php } ?>

								<?php if (isset($category_2['children'])) { ?>
								<?php foreach ($category_2['children'] as $category_3) { ?>
								<?php if ($category_3['child_id'] == $category_id) { ?>
								<option value="<?php echo $category_3['href']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
								<?php } else { ?>
								<option value="<?php echo $category_3['href']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
								<?php } ?>
								<?php } //endforeach categories_2?>
								<?php } //endif endforeach categories_2?>

								<?php } //endforeach categories_1?>
								<?php } //endforeach categories_0?>
							</select>
						</div>
						<!--end category-->
						<div class="limit pull-left">
							<span for="input-limit"><?php echo $objlang->get('text_limit'); ?></span>
							<select id="input-limit" class="form-control" onchange="location = this.value;">
								<?php foreach ($limits as $limits) { ?>
								<?php if ($limits['value'] == $limit) { ?>
								<option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
								<?php } else { ?>
								<option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
								<?php } ?>
								<?php } ?>
							</select>
						</div>
						<!--end limit-->
						<div class="sort pull-left">
							<span for="input-sort"><?php echo $objlang->get('text_sort'); ?></span>
							<select id="input-sort" class="form-control" onchange="location = this.value;">
								<?php foreach ($sorts as $sorts) { ?>
								<?php if ($sorts['value'] == $sort . '-' . $order) { ?>
								<option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
								<?php } else { ?>
								<option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
								<?php } ?>
								<?php } ?>
							</select>
						</div>
						<!--end sort-->									
					</div>
				</div>

				<!-- end filter -->
				<?php endif; ?>

				<!-- List Product -->
				<?php if (count($products) > 0): ?>
				<?php require( $productLayout );  ?>
				<?php endif; ?>

			</div><!-- end div deals -->

			

			<div class="row">
				<?php if (empty($products)): ?>
				<div class="col-sm-6 text-left"><?php echo $objlang->get('text_not_empty');?></div>
				<div class="col-sm-6 text-right">
					<div class="buttons">
						<div class="pull-right"><a href="<?php echo $objurl->link('common/home'); ?>" class="btn btn-primary"><?php echo $objlang->get('button_continue'); ?></a></div>
					</div>
				</div>
				<?php endif; ?>
			</div>
			
			<?php echo $content_bottom; ?>
		</div><!-- end div #content -->
		</div>
		<?php if( $SPAN[2] ): ?>
			<aside id="sidebar-right" class="col-md-<?php echo $SPAN[2];?>">	
				<?php echo $column_right; ?>
			</aside>
		<?php endif; ?>
	</div><!-- end div .row -->
</div><!-- end div .container -->
</div>
<?php echo $footer; ?>
