<?php
  $this->language( 'module/themecontrol' );
  $objlang = $this->registry->get('language');
?>
<div id="topbar" class="topbar-v2">
  <div class="container">
    <div class="row">
  <div class="col-lg-9 col-md-9 col-sm-12 col-xs-12">
    <div class="current-lang pull-left">
      <div class="btn-group box-language">
          <?php echo $language; ?>
      </div>
      <!-- currency -->
      <div class="btn-group box-currency">
          <?php echo $currency; ?>
      </div>
    </div>
  <div class="login pull-left hidden-xs hidden-sm">
    <ol class="breadcrumb">
      <li><a class="" href="<?php echo $account; ?>"><i class="hidden-sm fa-fw fa fa-user"></i><?php echo $text_account; ?></a></li>
      <li><a class="wishlist" href="<?php echo $wishlist; ?>" id="wishlist-total"><i class="hidden-sm fa-fw fa fa-edit"></i><?php echo $text_wishlist; ?></a></li>
      <li><a class="shoppingcart" href="<?php echo $shopping_cart; ?>"><i class="hidden-sm fa-fw fa fa-shopping-cart"></i><?php echo $text_shopping_cart; ?></a></li>
      <li><a class="last" href="<?php echo $checkout; ?>"><i class="hidden-sm fa-fw fa fa-sign-out"></i><?php echo $text_checkout; ?></a></li>
      <?php if ($logged) { ?>
        <li>  <a href="<?php echo $logout; ?>"><i class="hidden-sm fa-fw fa fa-share"></i><?php echo $text_logout; ?></a></li>
        <?php } else { ?>
        <li>  <a href="<?php echo $register; ?>"><i class="hidden-sm fa-fw fa fa-key"></i><?php echo $text_register; ?></a></li>
        <li>  <a href="<?php echo $login; ?>"><i class="hidden-sm fa-fw fa fa-lock"></i><?php echo $text_login; ?></a>  </li>
        <?php } ?>
    </ol>
  </div>
  <!-- Show Mobile -->          
      <div class="show-mobile hidden-lg hidden-md pull-right">     
        <div class="quick-user pull-left">
          <div class="quickaccess-toggle">
            <i class="fa fa-user"></i>                              
          </div>  
          <div class="inner-toggle">
            <div class="login links">
              <?php if ($logged) { ?>
                <a href="<?php echo $logout; ?>"><?php echo $text_logout; ?></a>
                <?php } else { ?>
                  <a href="<?php echo $register; ?>"><?php echo $text_register; ?></a>
                  <a href="<?php echo $login; ?>"><?php echo $text_login; ?></a>  
                <?php } ?> 
            </div>
          </div>            
        </div>
        <div class="quick-access pull-left">
          <div class="quickaccess-toggle">
            <i class="fa fa-list"></i>                              
          </div>  
          <div class="inner-toggle">
            <ul class="links pull-left">              
              <li><a class="wishlist" href="<?php echo $wishlist; ?>" id="mobile-wishlist-total"><i class="fa fa-list-alt"></i><?php echo $text_wishlist; ?></a></li>
              <li><a class="shoppingcart" href="<?php echo $shopping_cart; ?>"><i class="fa fa-bookmark"></i><?php echo $text_shopping_cart; ?></a></li>
              <li><a class="last checkout" href="<?php echo $checkout; ?>"><i class="fa fa-share"></i><?php echo $text_checkout; ?></a></li>
              <li><a class="account" href="<?php echo $account; ?>"><i class="fa fa-user"></i><?php echo $text_account; ?></a></li>               
            </ul>
          </div>            
        </div> 
      </div>
    <!-- End -->
  </div>
  <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12 same-cart">
      <div id="cart-top" class="cart-right">
          <div class="cart-top same-cart">
              <?php echo $cart; ?>
          </div>
      </div>
    </div> 
    

</div>
</div>
</div>