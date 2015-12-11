<?php 
	$objlang = $this->registry->get('language');
	$config = $this->registry->get('config');
?>
<?php if( !empty($blogs) ) { ?>
<div id="blog-carousel" class="widget-blogs block owl-carousel-play latest-posts latest-posts-v1 panel-default <?php echo $addition_cls?> <?php if ( isset($stylecls)&&$stylecls) { ?>box-<?php echo $stylecls; ?><?php } ?>">
	<?php if( $show_title ) { ?>
	<div class="panel-heading"><h4 class="panel-title"><?php echo $heading_title?></h4></div>
	<?php } ?>
		<div class="carousel-inner owl-carousel" data-show="1" data-pagination="false" data-navigation="true">

				<?php  $pages = array_chunk( $blogs, $itemsperpage); $span = 12/$cols; ?>

				<?php foreach ($pages as  $k => $tblogs ) {   ?>
				
						<?php foreach( $tblogs as $i => $blog ) {  $i=$i+1;?>
							<?php if( $cols > 1 && ($i%$cols == 1) ) { ?>
							<div class="row products-row">
							<?php } ?>

								<div class="col-lg-<?php echo $span;?> col-md-<?php echo $span;?> col-sm-<?php echo $span;?>">
						  			<div class="blog-item">
										<div class="latest-posts-body">
											<div class="latest-posts-img-profile">
												<?php if( $blog['thumb']  )  { ?>
													<div class="latest-posts-image effect">
															<a href="<?php echo $blog['link'];?>" class="blog-article">
													<img src="<?php echo $blog['thumb'];?>" title="<?php echo $blog['title'];?>" alt="<?php echo $blog['title'];?>" class="img-responsive"/>
															</a>								
													</div>
												<?php } ?>							
											</div>
											<div class="latest-posts-meta">
												<h4 class="latest-posts-title">
													<a href="<?php echo $blog['link'];?>" title="<?php echo $blog['title'];?>"><?php echo $blog['title'];?></a>
												</h4>						
												<div class="blog-meta">						
													<span class="created">
														<span class="day"><?php echo date("d",strtotime($blog['created']));?></span>
														<span class="month"><?php echo date("M",strtotime($blog['created']));?></span> 								
													</span>		
													<span class="comment_count"><i class="fa fa-comments"></i> <?php echo $blog['comment_count'];?></span>
									
												</div>

												<div class="shortinfo">
													<?php $blog['description'] = strip_tags($blog['description']); ?>
													<?php echo utf8_substr( $blog['description'],0, 150 );?>...
												</div>
												<div class="blog-readmore">
													<a href="<?php echo $blog['link'];?>"><?php echo $objlang->get('text_readmore');?></a>
												</div>
											</div>						
										</div>						
									</div> 
								</div>  		
								

						  	<?php if( $cols > 1 && ($i%$cols == 0 || $i==count($tblogs)) ) { ?>
							</div>
							<?php } ?>

						<?php } //endforeach; ?>
				<?php } ?>
		</div> 
		<?php if( count($blogs) > $itemsperpage ) { ?>
		<div class="carousel-controls">
			<a class="carousel-control left" href="#blog-carousel"   data-slide="prev"><i class="fa fa-angle-left"></i></a>
			<a class="carousel-control right" href="#blog-carousel"  data-slide="next"><i class="fa fa-angle-right"></i></a>
		</div>
		<?php } ?>
	</div>
<?php } ?>