<?php
  $objlang = $this->registry->get('language');
?>
<div class="default-footer <?php echo str_replace('_','-',$blockid); ?> <?php echo $blockcls;?>" id="pavo-<?php echo str_replace('_','-',$blockid); ?>">
  <div class="container">
    <div class="container-inner">
      <div class="row">
        
        <?php if ($informations) { ?>
        <div class="column col-xs-12 col-sm-6 col-md-3 col-lg-3">
            <div class="panel-heading"><h4 class="panel-title"><?php echo $text_information; ?></h4></div>
                <ul class="list-unstyled">
                  <?php foreach ($informations as $information) { ?>
                  <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
                  <?php } ?>
                </ul>
        </div>          
        <?php } ?>

        <div class="column col-xs-12 col-sm-6 col-md-3 col-lg-3">
          <div class="panel-heading"><h4 class="panel-title"><?php echo $text_service; ?></h4></div>
            <ul class="list-unstyled">
              <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
              <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
              <li><a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a></li>
              <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
            </ul>
        </div>

        <div class="column col-xs-12 col-sm-6 col-md-3 col-lg-3">
          <div class="panel-heading"><h4 class="panel-title"><?php echo $text_extra; ?></h4></div>
            <ul class="list-unstyled">
              <li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
              <li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
              <li><a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a></li>
              <li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>
            </ul>
        </div>

        <div class="column col-xs-12 col-sm-6 col-md-3 col-lg-3">
          <div class="panel-heading"><h4 class="panel-title"><?php echo $text_account; ?></h4></div>
            <ul class="list-unstyled">
              <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
              <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
              
              <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
              <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
            </ul>
        </div>
    </div>
      </div>
  </div>
</div>