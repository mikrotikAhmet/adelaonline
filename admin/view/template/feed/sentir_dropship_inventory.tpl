<div class="buttons pull-right">
    <button type="button" class="btn btn-mini btn-default" id="button-inventory-import" onclick="startImport()"><i class="fa fa-cloud-download"></i> Import/Update Inventory</button>
</div>
<br/>
<?php if ($inv_products) { ?>
    <div class="row">
        <div class="col-sm-12">
            <?php foreach ($inv_products as $product) { ?>
                <div class="col-sm-2">
                    <img src="<?php echo $product->image; ?>" alt="<?php echo $product->name; ?>" class="img-thumbnail img-responsive"/>
                    <div class="">
                        <button type="button" class="btn btn-mini btn-default" onclick="removeInventory('<?php echo $product->product_id?>')" style="width: 100%"><i class="fa fa-remove danger"></i> Remove</button>
                    </div>
                </div>
            <?php } ?>
        </div>
    </div>
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
<?php } ?>