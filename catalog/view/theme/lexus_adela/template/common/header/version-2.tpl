<?php
  $this->language( 'module/themecontrol' );
  $objlang = $this->registry->get('language');
  $megamenu = $helper->renderModule('pavmegamenu');
  $verticalmenu = $helper->renderModule('pavverticalmenu');
  if( isset($_COOKIE[$themeName .'_skin']) && $_COOKIE[$themeName .'_skin'] ){
    $skin = trim($_COOKIE[$themeName .'_skin']);
  }
?>

<div id="header-layout" class="header-v2">  
   <?php  require( ThemeControlHelper::getLayoutPath( 'common/addon/topbar-v1.tpl' ) );?>
   <div id="header-main">
      <div class="container">
      <div class="row">
        <div class="logo inner  col-lg-3 col-md-3 col-sm-3">
            <?php if( $logoType=='logo-theme'){ ?>
            <div id="logo-theme" class="logo-store pull-left">
                <a href="<?php echo $home; ?>">
                    <span><?php echo $name; ?></span>
                </a>
            </div>
            <?php } elseif ($logo) { ?>
            <div id="logo" class="logo-store pull-left"><a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a></div>
            <?php } ?>
        </div>
        <div class="col-lg-3 col-md-3 col-sm-3">
          <div class="call-top top-block">
            <?php
              if($content=$helper->getLangConfig('widget_call')){
              echo $content;
              }
            ?>
          </div>
         
        </div>  
        <div class="col-lg-3 col-md-3 col-sm-3">
          <div class="email-top top-block">
            <?php
              if($content=$helper->getLangConfig('widget_email')){
              echo $content;
              }
            ?>
          </div>
       
        </div>  
        <div class="col-lg-3 col-md-3 col-sm-3 line space-padding-lr-40 box-cart">
          <div id="cart-top" class="cart-top">
            <?php echo $cart; ?>
          </div>
          
        </div>        
      </div>
    </div>
    </div> 
    <div id="header-bot">
      <div class="container">
        <div class="row">
        <div class="col-lg-9 col-md-9 col-sm-12 col-xs-12">
        <div id="pav-mainnav" class="hidden-xs hidden-sm pull-left">
          
          <?php
          /**
          * Main Menu modules: as default if do not put megamenu, the theme will use categories menu for main menu
          */
          if (count($megamenu) && !empty($megamenu)) { echo $megamenu;?>
          <?php } elseif ($categories) { ?>
          <nav id="menu" class="navbar navbar-default">
            <div class="navbar-header"><span id="category" class="visible-xs"><?php echo $text_category; ?></span>
              <button type="button" class="btn btn-navbar navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse"><i class="fa fa-bars"></i></button>
            </div>
            <div class="collapse navbar-collapse navbar-ex1-collapse">
              <ul class="nav navbar-nav">
                <?php foreach ($categories as $category) { ?>
                <?php if ($category['children']) { ?>
                <li class="dropdown"><a href="<?php echo $category['href']; ?>" class="dropdown-toggle" data-toggle="dropdown"><?php echo $category['name']; ?></a>
                <div class="dropdown-menu">
                  <div class="dropdown-inner">
                    <?php foreach (array_chunk($category['children'], ceil(count($category['children']) / $category['column'])) as $children) { ?>
                    <ul class="list-unstyled">
                      <?php foreach ($children as $child) { ?>
                      <li><a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a></li>
                      <?php } ?>
                    </ul>
                    <?php } ?>
                  </div>
                  <a href="<?php echo $category['href']; ?>" class="see-all"><?php echo $text_all; ?> <?php echo $category['name']; ?></a> </div>
                </li>
                <?php } else { ?>
                <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
                <?php } ?>
                <?php } ?>
              </ul>
            </div>
          </nav>
          <?php } ?>
        </div>
        </div>
        <div id="search" class="col-lg-3 col-md-3 col-sm-12 col-xs-12">
            <div class="quick-access">
                <?php echo $search; ?>
            </div>
        </div>
        </div>
      </div>
    </div>
</div>
