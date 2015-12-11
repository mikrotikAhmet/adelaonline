<?php $objlang = $this->registry->get('language');?>
<?php if( count($testimonials) ) { ?>
	<?php $id = rand(1,10)+rand();?>
   <div id="pavtestimonial<?php echo $id;?>" class="slide pavtestimonial block panel-default">
	<div class="panel-heading"><h4 class="panel-title"><?php echo $objlang->get('text_testimonial'); ?></h4></div>
		<div class="carousel-inner">
			 <?php foreach ($testimonials as $i => $testimonial) {  ?>
				<div class="item <?php if($i==0) {?>active<?php } ?>">
	 				<div class="testimonial-item">
						<?php if(  $testimonial['description'] ) { ?>
						<div class="testimonial">
							<div><?php echo $testimonial['description']; ?></div>
						</div>
						<?php } ?>
						<div class="post-image">
							<div class="t-avatar pull-left"><img  alt="<?php echo strip_tags($testimonial['profile']); ?>" src="<?php echo $testimonial['thumb']; ?>" class="img-circle"/></div>
							<?php if(  $testimonial['profile'] ) { ?>
							<div class="profile pull-left">
								<div><?php echo $testimonial['profile']; ?></div>
							</div>
							<?php } ?>
							<?php if( $testimonial['video_link']) { ?>
							<a class="colorbox-t" href="<?php echo $testimonial['video_link'];?>"><?php echo $this->language->get('text_watch_video_testimonial');?></a>
							<?php } ?>
						</div>
					</div>
				</div>
			<?php } ?>
		</div>
	 		
		<?php if( count($testimonials) > 1 ){ ?>	
		<div class="carousel-controls">
			<a class="carousel-control left" href="#pavtestimonial<?php echo $id;?>" data-slide="prev"><i class="fa fa-angle-left"></i></a>
			<a class="carousel-control right" href="#pavtestimonial<?php echo $id;?>" data-slide="next"><i class="fa fa-angle-right"></i></a>
		</div>
		<?php } ?>
    </div>
	<?php if( count($testimonials) > 1 ){ ?>
	<script type="text/javascript">
	<!--
		$('#pavtestimonial<?php echo $id;?>').carousel({interval:<?php echo ( $auto_play_mode?$interval:'false') ;?>,auto:<?php echo $auto_play;?>,pause:'hover'});
	-->
	</script>
	<?php } ?>
<?php } ?>
