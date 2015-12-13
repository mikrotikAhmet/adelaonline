<?php 
 $helper =  ThemeControlHelper::getInstance( $this->registry );
 echo $header; ?>  
 <?php require( ThemeControlHelper::getLayoutPath( 'common/mass-header.tpl' )  ); ?>
<div class="main-columns">
<div class="container">
<div class="row"><?php if( $SPAN[0] ): ?>
			<aside id="sidebar-left" class="col-md-<?php echo $SPAN[0];?>">
				<?php echo $column_left; ?>
			</aside>	
		<?php endif; ?> 
   <div id="sidebar-main" class="col-md-<?php echo $SPAN[1];?>">
      <div id="content">
      <div class="pull-left">
        <?php require( ThemeControlHelper::getLayoutPath( 'common/mass-container.tpl' )  ); ?>
      </div>
      <?php if ($thumb || $description) { ?>
      <div class="category-info clearfix hidden-xs hidden-sm">
        <?php if ($thumb) { ?>
          <div class="image"><img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" class="img-responsive" /></div>
          <?php } ?>
          <?php if ($description) { ?>
          <div class="category-description wrapper">
            <?php echo $description; ?>
          </div>
          <?php } ?>
      </div>
      <?php } ?>
      <?php echo $content_top; ?>

      <?php if( false &&  $categories = $helper->getCategoriesById() ){   ?>
	   <div class="subcategories panel panel-default">
			<div class="panel-heading">
			  <h4 class="panel-title"><?php echo $text_refine; ?> </h4>
		   </div> 
			  <div class="panel-body">
					<?php $col=6; $i=0; $ncol = floor(12/$col); foreach( $categories as $category ){  $i++; ?>
            <?php if($i%$col==1) { ?>
            <div class="row">
            <?php } ?>
						<div class="col-lg-<?php echo $ncol; ?> col-md-3 col-sm-4"><div class="category-item">
							<?php if( $category['thumb'] ){ ?>
								   <div class="image">
                      <a href="<?php echo $category['href']; ?>">
                        <img src="<?php echo $category['thumb']; ?>" alt="<?php echo $category['name']; ?>" class="img-responsive" />
                      </a>
                  </div>
							<?php } ?>
							  <a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
						</div></div>
            <?php if( $i%$col==0 || $i==count($categories) ){ ?>
            </div>
            <?php } ?>
					<?php } ?>
        </div>
        </div>
        <?php } else if ($categories) { ?>
          <div class="refine-search">
            <h4><?php echo $heading_title; ?></h4>
            <div class="row">
                <div class="col-sm-12">
                    <div class="row">
                        <?php foreach ($categories as $category) { ?>
                        <div class="col-sm-3 text-center">
                            <a href="<?php echo $category['href']; ?>" class="text-muted">
                                <img alt="<?php echo $category['name']; ?>" class="img-responsive grayscale" src="<?php echo $category['refine_thumb']?>"/>
                               <span style="font-size:11px"> <?php echo $category['name']; ?></span>
                            </a>
                        </div>
                        <?php } ?>
                    </div>
                </div>
            </div>
         </div>    
      <?php } ?>
          <hr/>
      <?php if ($products) { ?>
     
      <?php require( ThemeControlHelper::getLayoutPath( 'common/product_collection.tpl' ) );  ?> 
      <?php } ?>

        <?php if (!$categories && !$products) { ?>
        <div class="content"><div class="wrapper"><?php echo $text_empty; ?></div></div>
        <div class="buttons">
          <div class="right"><a href="<?php echo $continue; ?>" class="button btn btn-default"><?php echo $button_continue; ?></a></div>
        </div>
        <?php } ?>

      
      <?php echo $content_bottom; ?></div>
   </div> 
<?php if( $SPAN[2] ): ?>
	<aside id="sidebar-right" class="col-md-<?php echo $SPAN[2];?>">	
		<?php echo $column_right; ?>
	</aside>
<?php endif; ?></div>
</div>
</div>
<?php echo $footer; ?>