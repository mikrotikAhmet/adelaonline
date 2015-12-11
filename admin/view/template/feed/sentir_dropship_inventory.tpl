<div class="buttons pull-right">
    <button type="button" class="" id="button-inventory-import" onclick="startImport()">Import Inventory</button>
</div>
<table class="table table-condensed table-hover">
    <thead>
        <tr>
            <td class="text-left">Product ID</td>
            <td class="text-left">Name</td>
            <td class="text-left">Image</td>
            <td class="text-left"><b>S</b>KU / <b>M</b>odel</td>
            <td class="text-left">MAP</td>
            <td></td>
        </tr>
    </thead>
    <tbody>
    <?php if ($inv_products) { ?>
        <?php foreach ($inv_products as $product) { ?>
            <tr>
                <td class="text-left"><?php echo $product->product_id?></td>
                <td class="text-left"><?php echo $product->name?></td>
                <td class="text-center"><?php if ($product->image) { ?>
                    <img src="<?php echo $product->image; ?>" alt="<?php echo $product->name; ?>" class="img-thumbnail" style="width: 40px"/>
                    <?php } else { ?>
                    <span class="img-thumbnail list"><i class="fa fa-camera fa-2x"></i></span>
                    <?php } ?>
                </td>
                <td class="text-left"><?php echo (!empty($product->sku) ? 'S'.$product->sku : 'M'.$product->model)?></td>
                <td class="text-left"><?php echo $currency->format($product->map,$product->base_currency)?></td>
                <td class="text-right"><a style="cursor: pointer" onclick="removeInventory('<?php echo $product->product_id?>')"><i class="fa fa-minus-square-o fa-1x"></i></a></td>
            </tr>
        <?php } ?>
    <?php } ?>
    </tbody>
</table>
<div class="row">
    <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
    <div class="col-sm-6 text-right"><?php echo $results; ?></div>
</div>
<script>

    function startImport(){

        $.ajax({
            url: 'index.php?route=feed/sentir_dropship/importInventory&token=<?php echo $token; ?>',
            dataType: 'json',
            beforeSend: function() {
                    $('#button-inventory-import').button('loading');
                $('#button-inventory-import').attr('disabled',true);
            },
            complete: function() {
                    $('#button-inventory-import').button('reset');
                $('#button-inventory-import').attr('disabled',false);
            },
            success: function(json) {
                console.log(json);

            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    }

    $('.img-thumbnail').hover(function(){
        $(this).addClass('transition');
    },function(){
        $(this).removeClass('transition');
    });

    function removeInventory(product_id){
        $.ajax({
            url: 'index.php?route=feed/sentir_dropship/removeInventory&token=<?php echo $token; ?>',
            type: 'post',
            dataType: 'json',
            data: 'product_id=' +product_id,
            beforeSend: function() {
//                $('#button-category-add').button('loading');
            },
            complete: function() {
//                $('#button-category-add').button('reset');
            },
            success: function(json) {
                $('#p'+product_id).attr('checked', false);
                $('#inventorylist').load('index.php?route=feed/sentir_dropship/getInventory&token=<?php echo $token; ?>');

            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    }
</script>