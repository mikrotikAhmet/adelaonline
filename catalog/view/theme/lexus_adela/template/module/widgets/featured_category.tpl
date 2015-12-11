<div class="widget-category hidden-xs hidden-sm panel clearfix <?php echo $addition_cls?>">
	<?php if( $show_title ) { ?>
	<div class="widget-heading panel-heading"><h4 class="panel-title"><?php echo $heading_title?></h4></div>
	<?php } ?>
	<div class="widget-inner">	
		<?php if(!empty($categories)) { ?>
			<div class="box-content">
				<ul class="list-unstyled">
					<?php foreach ($categories as $category): ?>
					<li>
						<div class="effect-adv">
						<a href="<?php echo $category['href']; ?>">
							<?php if ($category['image'] !== '') { ?>
							<img src="image/<?php echo $category['image']; ?>" alt="" class="img-responsive">
							<?php
							} ?>
						</a>
						</div>
						<div class="caption">
							<h5><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></h5>
							<div><a class="text-lighten" href="<?php echo $category['href']; ?>"><?php echo $category['items']; ?>&nbsp;<i class="fa fa-long-arrow-right"></i></a></div>
						</div>						
					</li>
					<?php endforeach ?>
				</ul>
			</div>
		<?php } ?>


	</div>
</div>