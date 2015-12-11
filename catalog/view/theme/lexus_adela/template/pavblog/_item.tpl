<div class="blog-item">
	<?php if( $blog['thumb'] && $cat_show_image )  { ?>					
		<img src="<?php echo $blog['thumb'];?>" alt="<?php echo $blog['title'];?>" title="<?php echo $blog['title'];?>" class="img-responsive" />	
	<?php } ?>
	<div class="blog-header">
		<h3 class="blog-title"><a href="<?php echo $blog['link'];?>" title="<?php echo $blog['title'];?>"><?php echo $blog['title'];?></a></h3>
	
	<div class="blog-meta">
		<?php if( $cat_show_created ) { ?>
		<span class="created">
			<i class="fa fa-clock-o">   <?php echo $objlang->get("text_created");?> :</i>
			<?php echo date("d-M-Y",strtotime($blog['created']));?>
		</span>
		<?php } ?>
		<?php if('cat_show_author') { ?>
		<span class="author"><i class="fa fa-pencil">   <?php echo $objlang->get("text_write_by");?></i> <?php echo $blog['author'];?></span>
		<?php } ?>
		<?php if('cat_show_category') { ?>
		<span class="publishin">
			<i class="fa fa-user">   <?php echo $objlang->get("text_published_in");?></i>
			<a href="<?php echo $blog['category_link'];?>" title="<?php echo $blog['category_title'];?>"><?php echo $blog['category_title'];?></a>
		</span>
		<?php } ?>
		
		<?php if('cat_show_hits') { ?>
		<span class="hits"><i class="fa fa-eye-open">   <?php echo $objlang->get("text_hits");?></i> <?php echo $blog['hits'];?></span>
		<?php } ?>
		<?php if('cat_show_comment_counter') { ?>
		<span class="comment_count"><i class="fa fa-comments">   <?php echo $objlang->get("text_comment_count");?></i> <?php echo $blog['comment_count'];?></span>
		<?php } ?>
	</div>
	</div>
	<div class="blog-body clearfix">	
		<?php if('cat_show_description') {?>
		<div class="description">
			<?php echo $blog['description'];?>
		</div>
		<?php } ?>
		<?php if('cat_show_readmore') { ?>
		<div class="blog-readmore">
			<a href="<?php echo $blog['link'];?>" class="btn btn-primary"><?php echo $objlang->get('text_readmore');?></a>
		</div>
		<?php } ?>
	</div>
</div>

