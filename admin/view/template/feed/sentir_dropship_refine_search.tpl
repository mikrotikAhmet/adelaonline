<?php if (isset($refine->CategoryObj)) { ?>
<?php if (count($refine->CategoryObj) <= 5) { ?>
<div class="row">
    <div class="col-sm-12">
        <ul>
            <?php foreach ($refine->CategoryObj as $key=>$category) { ?>
            <li><a style="cursor: pointer" onclick="getRefine('<?php echo $key?>','<?php echo str_replace("'","`",$category)?>')"><?php echo $category; ?></a></li>
            <?php } ?>
        </ul>
    </div>
</div>
<?php } else { ?>
<div class="row">
    <?php foreach (array_chunk($refine->CategoryObj, ceil(count($refine->CategoryObj) / 4)) as $refine->CategoryObj) { ?>
    <div class="col-sm-12">
        <ul>
            <?php foreach ($refine->CategoryObj as $key=>$category) { ?>
            <li><a style="cursor: pointer" onclick="getRefine('<?php echo $key?>','<?php echo str_replace("'","`",$category)?>)"><?php echo $category; ?></a></li>
            <?php } ?>
        </ul>
    </div>
    <?php } ?>
</div>
<?php } ?>
<?php } ?>