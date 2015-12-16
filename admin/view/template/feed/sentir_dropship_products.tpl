<?php if (isset($products->ProductObj)) { ?>
<h3><i class="fa fa-list"></i> Product List</h3>
<hr/>
<div class="row">
    <div class="col-sm-12">
        <?php foreach ($products->ProductObj as $product) { ?>
            <div class="col-sm-2" style="margin-bottom: 10px">
                <img src="<?php echo $product->image; ?>" alt="<?php echo $product->name; ?>" class="img-thumbnail img-responsive"/>
                <div>
                    <span id="sku" class="pull-left">
                        <?php if (in_array($product->product_id, $selected)) { ?>
                        <input id="p<?php echo $product->product_id?>" type="checkbox" class="selection" name="selected[]" value="<?php echo $product->product_id; ?>" checked="checked"/>
                        <?php } else { ?>
                        <input id="p<?php echo $product->product_id?>" type="checkbox" class="selection" name="selected[]" value="<?php echo $product->product_id; ?>" />
                        <?php } ?>
                        <b>SKU:</b> <?php echo (!empty($product->sku) ? 'S'.$product->sku : 'M'.$product->model)?>
                    </span>
                    <span id="price" class="pull-right"><b>Price :</b> <?php echo $currency->format($product->map,$product->base_currency)?></span>
                </div>
            </div>
        <?php }?>
    </div>
</div>
<div class="row">
    <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
    <div class="col-sm-6 text-right"><?php echo $results; ?></div>
</div>
<?php } ?>
<script>

    $(".selection:checked").each(function() {
//        $('#p'+this.value).attr('disabled',true);
    });

    $(".selection").change(function() {

        var main_category_id = $('#main-category').html();

        var url = '';
        var matches = [];

        if ($(this).is(":checked")){
            url = 'index.php?route=feed/sentir_dropship/setInventory&token=<?php echo $token; ?>&type=add&category_id='+main_category_id;

            $('input[type=checkbox]').each(function() {
                if (this.checked){
                    matches.push(this.value);
                }
//            $('#p'+this.value).attr('disabled',true);
            });


        } else {
            url = 'index.php?route=feed/sentir_dropship/setInventory&token=<?php echo $token; ?>&type=remove&category_id='+main_category_id;

            $('input[type=checkbox]').each(function() {
                if (!this.checked){
                    matches.push(this.value);
                }
//            $('#p'+this.value).attr('disabled',true);
            });
        }


        $.ajax({
            url: url,
            type: 'post',
            dataType: 'json',
            data: 'selected=' +matches,
            beforeSend: function() {
//                $('#button-category-add').button('loading');
            },
            complete: function() {
//                $('#button-category-add').button('reset');
            },
            success: function(json) {

                $('#inventorylist').load('index.php?route=feed/sentir_dropship/getInventory&token=<?php echo $token; ?>');

            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });
</script>