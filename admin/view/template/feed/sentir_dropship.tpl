<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
<div class="page-header">
    <div class="container-fluid">
        <div class="pull-right">
            <button type="submit" form="form-sentir-base" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
            <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
        <h1><?php echo $heading_title; ?></h1>
        <ul class="breadcrumb">
            <?php foreach ($breadcrumbs as $breadcrumb) { ?>
            <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
            <?php } ?>
        </ul>
    </div>
</div>
<div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
        </div>
        <div class="panel-body">
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-sentir-base" class="form-horizontal">
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#tab-setting" data-toggle="tab"><?php echo $tab_settings; ?></a></li>
                    <?php if ($is_apiSet) { ?>
                    <li><a href="#tab-category" data-toggle="tab"><?php echo $tab_category; ?></a></li>
                    <li><a href="#tab-inventory" data-toggle="tab"><?php echo $tab_inventory; ?></a></li>
                    <?php } ?>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane active" id="tab-setting">
                        <div class="form-group required">
                            <label class="col-sm-2 control-label" for="input-api-url"><?php echo $entry_end_point; ?></label>
                            <div class="col-sm-10">
                                <input type="text" name="sentir_dropship_end_point" value="<?php echo $sentir_dropship_end_point; ?>" placeholder="<?php echo $entry_end_point; ?>" id="input-api-url" class="form-control" />
                                <?php if ($error_end_point) { ?>
                                <div class="text-danger"><?php echo $error_end_point; ?></div>
                                <?php } ?>
                            </div>
                        </div>
                        <div class="form-group required">
                            <label class="col-sm-2 control-label" for="input-api-id"><?php echo $entry_api_id; ?></label>
                            <div class="col-sm-10">
                                <input type="text" name="sentir_dropship_api_id" value="<?php echo $sentir_dropship_api_id; ?>" placeholder="<?php echo $entry_api_id; ?>" id="input-api-id" class="form-control" />
                                <?php if ($error_api_id) { ?>
                                <div class="text-danger"><?php echo $error_api_id; ?></div>
                                <?php } ?>
                            </div>
                        </div>
                        <div class="form-group required">
                            <label class="col-sm-2 control-label" for="input-api-key"><?php echo $entry_api_key; ?></label>
                            <div class="col-sm-10">
                                <input type="text" name="sentir_dropship_api_key" value="<?php echo $sentir_dropship_api_key; ?>" placeholder="<?php echo $entry_api_key; ?>" key="input-api-key" class="form-control" />
                                <?php if ($error_api_key) { ?>
                                <div class="text-danger"><?php echo $error_api_key; ?></div>
                                <?php } ?>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
                            <div class="col-sm-10">
                                <select name="sentir_dropship_status" id="input-status" class="form-control">
                                    <?php if ($sentir_dropship_status) { ?>
                                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                    <option value="0"><?php echo $text_disabled; ?></option>
                                    <?php } else { ?>
                                    <option value="1"><?php echo $text_enabled; ?></option>
                                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                    <?php } ?>
                                </select>
                            </div>
                        </div>
                    </div>
                    <?php if ($is_apiSet) { ?>
                    <div class="tab-pane" id="tab-category">
                        <div class="">
                            <button type="button" id="button-import" data-toggle="tooltip" title="<?php echo $button_import; ?>" class="btn btn-success"><i class="fa fa fa-upload"></i></button>
                        </div>
                        <div class="clear-fix"></div>
                        <br/>
                        <div id="category"></div>
                        <br />

                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="input-data-feed"><?php echo $entry_sentir_category; ?></label>
                            <div class="col-sm-10">
                                <div class="input-group">
                                    <input type="text" name="sentir_dropship_category" value="" placeholder="<?php echo $entry_sentir_category; ?>" id="input-sentir-category" class="form-control" />
                                    <input type="hidden" name="sentir_dropship_category_id" value="" />
                                    <span class="input-group-btn"><button type="button" id="button-category-list" data-toggle="tooltip" data-target="#category-list" title="<?php echo $button_category_list; ?>" class="btn btn-primary"><i class="fa fa-list"></i></button></span>
                                </div>
                                <br/>
                                <div class="input-group">
                                    <input type="text" name="category" value="" placeholder="<?php echo $entry_category; ?>" id="input-category" class="form-control" />
                                    <input type="hidden" name="category_id" value="" />
                                    <span class="input-group-btn"><button type="button" id="button-category-add" data-toggle="tooltip" title="<?php echo $button_category_add; ?>" class="btn btn-primary"><i class="fa fa-plus"></i></button></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane" id="tab-inventory">
                        <div class="row">
                            <div class="col-md-4">
                                <div id="category-localized"></div>
                                <div class="input-group">
                                    <select name="" id="input-localized-category" class="form-control" onchange="getRefine(this.value,$(this).prop('data-name'));setMainCategory(this.value)">
                                        <option value="">--Select--</option>
                                        <?php foreach ($sentir_dropship_categories as $category) { ?>
                                        <option value="<?php echo $category['sentir_dropship_category_id']?>" data-name="<?php echo str_replace("'","`",$category['sentir_dropship_category']); ?>"><?php echo str_replace("'","`",$category['sentir_dropship_category']); ?></option>
                                        <?php } ?>
                                    </select>
                                </div>
                                <br />
                            </div>
                            <div class="col-md-8">
                                <div id="category-breadcrumb"></div>
                                <div id="category-refine"></div>
                                <hr/>
                            </div>
                        </div>
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#tab-products" data-toggle="tab">Products</a></li>
                            <li><a href="#tab-myinventory" data-toggle="tab">My Inventory</a></li>
                        </ul>
                        <div class="tab-content">
                            <div class="tab-pane active" id="tab-products">
                                <div class="text-muted">Working Category ID: <span id="main-category"></span></div>
                                <div id="category-products"></div>
                                <br />
                            </div>
                            <div class="tab-pane" id="tab-myinventory">
                                <div id="inventorylist"></div>
                            </div>
                        </div>
                    </div>
                    <?php } ?>
                </div>
            </form>
        </div>
    </div>
</div>
<?php if ($is_apiSet) { ?>
<!-- Modal -->
<div class="modal fade" id="category-list" tabindex="-1" role="dialog" aria-labelledby="category-list">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Modal title</h4>
            </div>
            <div class="modal-body">
                <div id="main-category-list"></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<?php } ?>
<script type="text/javascript"><!--
    // sentir Category
    $('input[name=\'sentir_dropship_category\']').autocomplete({
        'source': function(request, response) {
            $.ajax({
                url: 'index.php?route=feed/sentir_dropship/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
                dataType: 'json',
                success: function(json) {
                    response($.map(json, function(item) {
                        return {
                            label: item['name'],
                            value: item['sentir_dropship_category_id']
                        }
                    }));
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                }
            });
        },
        'select': function(item) {
            $(this).val(item['label']);
            $('input[name=\'sentir_dropship_category_id\']').val(item['value']);
        }
    });

    // Category
    $('input[name=\'category\']').autocomplete({
        'source': function(request, response) {
            $.ajax({
                url: 'index.php?route=catalog/category/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
                dataType: 'json',
                success: function(json) {
                    response($.map(json, function(item) {
                        return {
                            label: item['name'],
                            value: item['category_id']
                        }
                    }));
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                }
            });
        },
        'select': function(item) {
            $(this).val(item['label']);
            $('input[name="category_id"]').val(item['value']);
        }
    });

    $('#category').delegate('.pagination a', 'click', function(e) {
        e.preventDefault();

        $('#category').load(this.href);
    });

    $('#category').load('index.php?route=feed/sentir_dropship/category&token=<?php echo $token; ?>');

    $('#category-localized').delegate('.pagination a', 'click', function(e) {
        e.preventDefault();

        $('#category-localized').load(this.href);
    });

    $('#category-localized').load('index.php?route=feed/sentir_dropship/categorylocalized&token=<?php echo $token; ?>');

    $('#button-category-add').on('click', function() {
        $.ajax({
            url: 'index.php?route=feed/sentir_dropship/addcategory&token=<?php echo $token; ?>',
            type: 'post',
            dataType: 'json',
            data: 'sentir_dropship_category_id=' + $('input[name=\'sentir_dropship_category_id\']').val() + '&category_id=' + $('input[name=\'category_id\']').val(),
            beforeSend: function() {
                $('#button-category-add').button('loading');
            },
            complete: function() {
                $('#button-category-add').button('reset');
            },
            success: function(json) {
                $('.alert').remove();

                if (json['error']) {
                    $('#category').before('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                }

                if (json['success']) {
                    $('#category').load('index.php?route=feed/sentir_dropship/category&token=<?php echo $token; ?>');

                    $('#category').before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');

                    $('input[name=\'category\']').val('');
                    $('input[name=\'category_id\']').val('');
                    $('input[name=\'sentir_dropship_category\']').val('');
                    $('input[name=\'sentir_dropship_category_id\']').val('');
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });

    $('#category').delegate('.btn-danger', 'click', function() {
        var node = this;

        $.ajax({
            url: 'index.php?route=feed/sentir_dropship/removecategory&token=<?php echo $token; ?>',
            type: 'post',
            data: 'category_id=' + encodeURIComponent(this.value),
            dataType: 'json',
            crossDomain: true,
            beforeSend: function() {
                $(node).button('loading');
            },
            complete: function() {
                $(node).button('reset');
            },
            success: function(json) {
                $('.alert').remove();

                // Check for errors
                if (json['error']) {
                    $('#content > .container-fluid').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                }

                if (json['success']) {
                    $('#category').load('index.php?route=feed/sentir_dropship/category&token=<?php echo $token; ?>');

                    $('#category').before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });

    $('#button-import').on('click', function() {

        if (typeof timer != 'undefined') {
            clearInterval(timer);
        }

        timer = setInterval(function() {
                clearInterval(timer);

                $.ajax({
                    url: 'index.php?route=feed/sentir_dropship/import&token=<?php echo $token; ?>',
                    type: 'post',
                    dataType: 'json',
                    cache: false,
                    contentType: false,
                    processData: false,
                    beforeSend: function() {
                        $('#button-import').button('loading');
                    },
                    complete: function() {
                        $('#button-import').button('reset');
                    },
                    success: function(json) {
                        $('.alert').remove();

                        if (json['error']) {
                            $('#content > .container-fluid').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                        }

                        if (json['success']) {
                            $('#content > .container-fluid').prepend('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                        }
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });

        }, 500);
    });

    $('#button-category-list').on('click', function() {

        $('#main-category-list').load('index.php?route=feed/sentir_dropship/getCategories&token=<?php echo $token; ?>');
        $('#category-list').modal('show');
    });

    $('#main-category-list').delegate('.pagination a', 'click', function(e) {
        e.preventDefault();

        $('#main-category-list').load(this.href);
    });

    $('#inventorylist').load('index.php?route=feed/sentir_dropship/getInventory&token=<?php echo $token; ?>');

    //--></script>
</div>
<?php echo $footer; ?>
