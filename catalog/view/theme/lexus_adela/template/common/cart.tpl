<?php $objlang = $this->registry->get('language');  ?>

<div id="cart" class="clearfix">
    <div data-toggle="dropdown" data-loading-text="<?php echo $text_loading; ?>" class="heading media dropdown-toggle">      
      <div class="cart-inner media-body">
        <a>
          <i class="icon-cart hidden-sm"></i>
          <div class="wrap-cart">
            <b class="text-cart"><?php echo $objlang->get("text_shopping_cart"); ?></b><br>
            <span id="cart-total" class="cart-total"><?php echo $text_items; ?></span>
            <i class="fa fa-angle-down"></i>            
          </div>
        </a>
      </div>
    </div>
    
    <ul class="dropdown-menu content">
      <?php if ($products || $vouchers) { ?>
      <li>
        <table class="table">
          <?php foreach ($products as $product) { ?>
          <tr>
            <td class="text-center"><?php if ($product['thumb']) { ?>
              <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
              <?php } ?></td>
            <td class="text-left"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
              <?php if ($product['option']) { ?>
              <?php foreach ($product['option'] as $option) { ?>
              <br />
              - <small><?php echo $option['name']; ?> <?php echo $option['value']; ?></small>
              <?php } ?>
              <?php } ?>
              <?php if ($product['recurring']) { ?>
              <br />
              - <small><?php echo $text_recurring; ?> <?php echo $product['recurring']; ?></small>
              <?php } ?>
              <br />
              <?php echo $product['quantity']; ?> x <b><?php echo $product['total']; ?></b>
            </td>

            <td class="text-center"><button type="button" onclick="cart.remove('<?php echo $product['cart_id']; ?>');" title="<?php echo $button_remove; ?>" class="btn btn-primary btn-xs"><i class="fa fa-times"></i></button></td>
          </tr>
          <?php } ?>
          <?php foreach ($vouchers as $voucher) { ?>
          <tr>
            <td class="text-center"></td>
            <td class="text-left"><?php echo $voucher['description']; ?></td>
            <td class="text-right">x&nbsp;1</td>
            <td class="text-right"><?php echo $voucher['amount']; ?></td>
            <td class="text-center text-danger"><button type="button" onclick="voucher.remove('<?php echo $voucher['key']; ?>');" title="<?php echo $button_remove; ?>" class="btn btn-primary btn-xs"><i class="fa fa-times"></i></button></td>
          </tr>
          <?php } ?>
        </table>
      </li>
      <li>
        <div class="table-responsive">
          <table class="table table-v4">
            <?php foreach ($totals as $total) { ?>
            <tr>
              <td class="text-right"><strong><?php echo $total['title']; ?></strong></td>
              <td class="text-right"><?php echo $total['text']; ?></td>
            </tr>
            <?php } ?>
          </table>
          <p class="text-center view-cart">
            <a href="<?php echo $cart; ?>" class="btn btn-primary text-light space-padding-10">
              <?php echo $text_cart; ?>
            </a>
            <a href="<?php echo $checkout; ?>" class="btn btn-primary text-light space-padding-10">
              <?php echo $text_checkout; ?></a>
          </p>
        </div>
      </li>
      <?php } else { ?>
      <li>
        <p class="text-center"><?php echo $text_empty; ?></p>
      </li>
      <?php } ?>
    </ul>
</div>
