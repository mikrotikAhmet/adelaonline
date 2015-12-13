<!--<table class="table table-bordered">
    <thead>
    <tr>
        <td class="text-left"><?php echo $column_sentir_category; ?></td>
        <td class="text-left"></td>
    </tr>
    </thead>
    <tbody>
    <?php if ($sentir_dropship_categories) { ?>
    <?php foreach ($sentir_dropship_categories as $sentir_dropship_category) { ?>
    <tr>
        <td class="text-left"><?php echo $sentir_dropship_category['sentir_dropship_category']; ?></td>
        <td class="text-right"><a onclick="getRefine('<?php echo $sentir_dropship_category['sentir_dropship_category_id']; ?>','<?php echo str_replace("'","`",$sentir_dropship_category['sentir_dropship_category']); ?>');setMainCategory('<?php echo $sentir_dropship_category['sentir_dropship_category_id']; ?>')" style="cursor: pointer"><i class="fa fa-cog fa-1x"></i></a> </td>
    </tr>
    <?php } ?>
    <?php } else { ?>
    <tr>
        <td class="text-center" colspan="4"><?php echo $text_no_results; ?></td>
    </tr>
    <?php } ?>
    </tbody>
</table>
<div class="row">
    <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
    <div class="col-sm-6 text-right"><?php echo $results; ?></div>
</div>-->
<script>
    function setMainCategory(category_id){
        $('#main-category').html(category_id);
    }

    function getRefine(category_id,name){

        var bread = "";

        bread ='<a style="cursor: pointer"><b>'+name+'</b></a>';

        $.ajax({
            url: 'index.php?route=feed/sentir_dropship/refine&token=<?php echo $token; ?>',
            type: 'post',
            dataType: 'html',
            data: 'category_id=' +category_id,
            beforeSend: function() {
//                $('#button-category-add').button('loading');
            },
            complete: function() {
//                $('#button-category-add').button('reset');
            },
            success: function(html) {
//                $('#category-breadcrumb').html(bread);
                $('#category-refine').html(html);
                getProducts(category_id);
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    }

    function getProducts(category_id){

        $body = $("body");

        $(document).on({
            ajaxStart: function() { $body.addClass("loading");    },
            ajaxStop: function() { $body.removeClass("loading"); }
        });

        $.ajax({
            url: 'index.php?route=feed/sentir_dropship/getProducts&token=<?php echo $token; ?>',
            type: 'post',
            dataType: 'html',
            data: 'category_id=' +category_id,
            beforeSend: function() {
//                $('#button-category-add').button('loading');
            },
            complete: function() {
//                $('#button-category-add').button('reset');
            },
            success: function(html) {
                $('#category-products').html(html);
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });

    }

    $('#inventorylist').delegate('.pagination a', 'click', function(e) {
        e.preventDefault();

        $('#inventorylist').load(this.href);
    });

    $('#category-products').delegate('.pagination a', 'click', function(e) {
        e.preventDefault();

        $('#category-products').load(this.href);
    });
</script>
