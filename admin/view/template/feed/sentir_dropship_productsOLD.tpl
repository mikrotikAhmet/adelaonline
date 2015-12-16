        <?php if (isset($products->ProductObj)) { ?>
        <table class="table table-condensed table-responsive">
            <thead>
            <tr>
                <td style="width: 1px;" class="text-center"><input class="selection" type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
                <th>Name</th>
                <th>Image</th>
                <th>Source Category ID</th>
                <th><b>S</b>KU / <b>M</b>odel</th>
                <th>MAP</th>
            </tr>
            </thead>
            <tbody>
            <?php foreach ($products->ProductObj as $product) { ?>
            <tr>
                <td class="text-center"><?php if (in_array($product->product_id, $selected)) { ?>
                    <input id="p<?php echo $product->product_id?>" type="checkbox" class="selection" name="selected[]" value="<?php echo $product->product_id; ?>" checked="checked"/>
                    <?php } else { ?>
                    <input id="p<?php echo $product->product_id?>" type="checkbox" class="selection" name="selected[]" value="<?php echo $product->product_id; ?>" />
                    <?php } ?></td>
                <td class="text-left"><?php echo $product->name?></td>
                <td class="text-center"><?php if ($product->image) { ?>
                    <img src="<?php echo $product->image; ?>" alt="<?php echo $product->name; ?>" class="img-thumbnail" style="width: 40px"/>
                    <?php } else { ?>
                    <span class="img-thumbnail list"><i class="fa fa-camera fa-2x"></i></span>
                    <?php } ?>
                </td>
                <td><?php echo $product->category_id?></td>
                <td class="text-left"><?php echo (!empty($product->sku) ? 'S'.$product->sku : 'M'.$product->model)?></td>
                <td class="text-left"><?php echo $currency->format($product->map,$product->base_currency)?></td>
            </tr>
            <?php } ?>
            </tbody>
        </table>
        <div class="row">
            <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
            <div class="col-sm-6 text-right"><?php echo $results; ?></div>
        </div>
        <?php } ?>
<script>

    $('.img-thumbnail').hover(function(){
        $(this).addClass('transition');
    },function(){
        $(this).removeClass('transition');
    });

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
