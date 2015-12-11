<?php 

$query['pavmegamenu'][]  = "DELETE FROM `".DB_PREFIX ."setting` WHERE `code`='pavmegamenu' and `key` = 'pavmegamenu_module'";

$query['pavmegamenu'][]  = "DELETE FROM `".DB_PREFIX ."setting` WHERE `code`='pavmegamenu_params' and `key` = 'params'";
$query['pavmegamenu'][] =  " 
INSERT INTO `".DB_PREFIX ."setting` (`setting_id`, `store_id`, `code`, `key`, `value`, `serialized`) VALUES
(0, 0, 'pavmegamenu_params', 'pavmegamenu_params', '[{\"submenu\":1,\"subwidth\":1000,\"id\":2,\"align\":\"aligned-fullwidth\",\"group\":0,\"cols\":3,\"rows\":[{\"cols\":[{\"widgets\":\"wid-62|wid-63\",\"colwidth\":3},{\"widgets\":\"wid-64|wid-65\",\"colwidth\":3},{\"widgets\":\"wid-66|wid-67\",\"colwidth\":3},{\"widgets\":\"wid-68|wid-69\",\"colwidth\":3}]}]},{\"id\":19,\"group\":0,\"cols\":1,\"submenu\":1,\"align\":\"aligned-left\",\"rows\":[{\"cols\":[{\"type\":\"menu\",\"colwidth\":12}]}]},{\"id\":23,\"group\":0,\"cols\":1,\"submenu\":1,\"align\":\"aligned-left\",\"rows\":[{\"cols\":[{\"type\":\"menu\",\"colwidth\":12}]}]},{\"id\":29,\"group\":0,\"cols\":1,\"submenu\":1,\"align\":\"aligned-left\",\"rows\":[{\"cols\":[{\"type\":\"menu\",\"colwidth\":12}]}]}]', 0);

";

$query['pavverticalmenu'][]  = "DELETE FROM `".DB_PREFIX ."setting` WHERE `code`='pavverticalmenu_params' and `key` = 'params'";
$query['pavverticalmenu'][] ="INSERT INTO `".DB_PREFIX ."setting` (`setting_id`, `store_id`, `code`, `key`, `value`, `serialized`) VALUES
(0, 0, 'pavverticalmenu_params', 'params', '[{\"submenu\":1,\"subwidth\":700,\"id\":2,\"group\":0,\"cols\":3,\"rows\":[{\"cols\":[{\"widgets\":\"wid-19\",\"colwidth\":12,\"colclass\":\"sidebar\"}]}]},{\"submenu\":1,\"subwidth\":600,\"id\":5,\"group\":0,\"cols\":1,\"rows\":[{\"cols\":[{\"widgets\":\"wid-61\",\"colwidth\":5},{\"widgets\":\"wid-62\",\"colwidth\":7}]}]},{\"submenu\":1,\"subwidth\":700,\"id\":7,\"group\":0,\"cols\":1,\"rows\":[{\"cols\":[{\"widgets\":\"wid-55|wid-59\",\"colwidth\":4},{\"widgets\":\"wid-56|wid-60\",\"colwidth\":4}]}]}]', 0);
";

$query['pavblog'][] ="
INSERT INTO `".DB_PREFIX ."layout_route` (`layout_route_id`, `layout_id`, `store_id`, `route`) VALUES(134, 14, 0, 'pavblog/%');";
$query['pavblog'][] ="
INSERT INTO `".DB_PREFIX ."layout` (`layout_id`, `name`) VALUES (14, 'Pav Blog');";
?>