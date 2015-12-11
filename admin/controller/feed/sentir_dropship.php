<?php
/**
 * Created by PhpStorm.
 * User: root
 * Date: 12/2/15
 * Time: 3:14 PM
 */

class ControllerFeedSentirDropship extends Controller {
    private $error = array();
    private $product_selection = array();

    public function index() {
        $this->load->language('feed/sentir_dropship');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('setting/setting');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $this->model_setting_setting->editSetting('sentir_dropship', $this->request->post);

            $this->session->data['success'] = $this->language->get('text_success');

            $this->response->redirect($this->url->link('feed/sentir_dropship', 'token=' . $this->session->data['token'], 'SSL'));
        }

        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_edit'] = $this->language->get('text_edit');
        $data['text_enabled'] = $this->language->get('text_enabled');
        $data['text_disabled'] = $this->language->get('text_disabled');
        $data['text_import'] = $this->language->get('text_import');

        $data['entry_sentir_category'] = $this->language->get('entry_sentir_category');
        $data['entry_category'] = $this->language->get('entry_category');
        $data['entry_end_point'] = $this->language->get('entry_end_point');
        $data['entry_api_id'] = $this->language->get('entry_api_id');
        $data['entry_api_key'] = $this->language->get('entry_api_key');
        $data['entry_data_feed'] = $this->language->get('entry_data_feed');
        $data['entry_status'] = $this->language->get('entry_status');

        $data['button_import'] = $this->language->get('button_import');
        $data['button_save'] = $this->language->get('button_save');
        $data['button_cancel'] = $this->language->get('button_cancel');
        $data['button_category_add'] = $this->language->get('button_category_add');
        $data['button_category_list'] = $this->language->get('button_category_list');

        $data['tab_settings'] = $this->language->get('tab_settings');
        $data['tab_category'] = $this->language->get('tab_category');
        $data['tab_inventory'] = $this->language->get('tab_inventory');

        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }

        if (isset($this->error['end_point'])) {
            $data['error_end_point'] = $this->error['end_point'];
        } else {
            $data['error_end_point'] = '';
        }

        if (isset($this->error['api_id'])) {
            $data['error_api_id'] = $this->error['api_id'];
        } else {
            $data['error_api_id'] = '';
        }

        if (isset($this->error['api_key'])) {
            $data['error_api_key'] = $this->error['api_key'];
        } else {
            $data['error_api_key'] = '';
        }

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_feed'),
            'href' => $this->url->link('extension/feed', 'token=' . $this->session->data['token'], 'SSL')
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('feed/sentir_dropship', 'token=' . $this->session->data['token'], 'SSL')
        );

        $data['action'] = $this->url->link('feed/sentir_dropship', 'token=' . $this->session->data['token'], 'SSL');

        $data['cancel'] = $this->url->link('extension/feed', 'token=' . $this->session->data['token'], 'SSL');

        $data['token'] = $this->session->data['token'];

        if (!$this->config->get('sentir_dropship_api_key') || !$this->config->get('sentir_dropship_api_id')){

            $data['is_apiSet'] = false;
        } else {
            $data['is_apiSet'] = true;
        }

        $data['data_feed'] = HTTP_CATALOG . 'index.php?route=feed/sentir_dropship';

        if (isset($this->request->post['sentir_dropship_api_id'])) {
            $data['sentir_dropship_api_id'] = $this->request->post['sentir_dropship_api_id'];
        } else {
            $data['sentir_dropship_api_id'] = $this->config->get('sentir_dropship_api_id');
        }

        if (isset($this->request->post['sentir_dropship_api_key'])) {
            $data['sentir_dropship_api_key'] = $this->request->post['sentir_dropship_api_key'];
        } else {
            $data['sentir_dropship_api_key'] = $this->config->get('sentir_dropship_api_key');
        }

        if (isset($this->request->post['sentir_dropship_status'])) {
            $data['sentir_dropship_status'] = $this->request->post['sentir_dropship_status'];
        } else {
            $data['sentir_dropship_status'] = $this->config->get('sentir_dropship_status');
        }

        if (isset($this->request->post['sentir_dropship_end_point'])) {
            $data['sentir_dropship_end_point'] = $this->request->post['sentir_dropship_end_point'];
        } else {
            $data['sentir_dropship_end_point'] = $this->config->get('sentir_dropship_end_point');
        }

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('feed/sentir_dropship.tpl', $data));
    }

    protected function validate() {
        if (!$this->user->hasPermission('modify', 'feed/sentir_dropship')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if (!empty($this->request->post['sentir_dropship_end_point']) && filter_var($this->request->post['sentir_dropship_end_point'], FILTER_VALIDATE_URL) === FALSE) {
            $this->error['end_point'] = $this->language->get('error_end_point');
        }

        if ((utf8_strlen(trim($this->request->post['sentir_dropship_api_id'])) < 3) || (utf8_strlen(trim($this->request->post['sentir_dropship_api_id'])) > 16)) {
            $this->error['api_id'] = $this->language->get('error_api_id');
        }

        if ((utf8_strlen($this->request->post['sentir_dropship_api_key']) < 10) || (utf8_strlen($this->request->post['sentir_dropship_api_key']) > 64)) {
            $this->error['api_key'] = $this->language->get('error_api_key');
        }

        return !$this->error;
    }

    public function install() {
        $this->load->model('feed/sentir_dropship');

        $this->model_feed_sentir_dropship->install();
    }

    public function uninstall() {
        $this->load->model('feed/sentir_dropship');

        $this->model_feed_sentir_dropship->uninstall();
    }

    public function importInventory(){

        require DIR_SYSTEM . 'library/sentir_encryption.php';

        $json = array();


        $secret = md5(date('Y-m-d H:s:i'));

        $sentir_crypto = new SentirEncryption($secret);

        $this->load->model('feed/sentir_dropship');

        $results = $this->model_feed_sentir_dropship->getCollection();

        $collection = $sentir_crypto->encrypt($results);

        //Connect To API

        $url = $this->config->get('sentir_dropship_end_point');

        $post_string = '<?xml version="1.0" encoding="UTF-8"?>
        <request>
            <authentication>
                <api_id>'.$this->config->get('sentir_dropship_api_id').'</api_id>
                <api_key>'.$this->config->get('sentir_dropship_api_key').'</api_key>
                <mode>'.($this->config->get('sentir_dropship_status') ? 'production' : null).'</mode>
            </authentication>
            <method>createFile</method>
            <secret>'.$secret.'</secret>
            <collection>'.$collection.'</collection>
        </request>';

        $postfields = $post_string;

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_TIMEOUT, 60);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $postfields);

        $obj = curl_exec($ch);

        $res = json_decode($obj);

        foreach ($res->ProductsObj as $product){

            $this->model_feed_sentir_dropship->importData($product);
        }

        $json[] = $obj;

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));

    }

    public function refine(){

        $category_id = $this->request->post['category_id'];

        //Connect To API

        $url = $this->config->get('sentir_dropship_end_point');

        $post_string = '<?xml version="1.0" encoding="UTF-8"?>
        <request>
            <authentication>
                <api_id>'.$this->config->get('sentir_dropship_api_id').'</api_id>
                <api_key>'.$this->config->get('sentir_dropship_api_key').'</api_key>
                <mode>'.($this->config->get('sentir_dropship_status') ? 'production' : null).'</mode>
            </authentication>
            <method>getCategory</method>
            <category_id>'.$category_id.'</category_id>
        </request>';

        $postfields = $post_string;

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_TIMEOUT, 60);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $postfields);

        $obj = curl_exec($ch);

        $res = json_decode($obj);

        $data['refine']=$res;


        $this->response->setOutput($this->load->view('feed/sentir_dropship_refine_search.tpl', $data));

    }

    public function import() {
        $this->load->language('feed/sentir_dropship');

        $json = array();

        // Check user has permission
        if (!$this->user->hasPermission('modify', 'feed/sentir_dropship')) {
            $json['error'] = $this->language->get('error_permission');
        }

        //Connect To API

        $url = $this->config->get('sentir_dropship_end_point');

        $post_string = '<?xml version="1.0" encoding="UTF-8"?>
        <request>
            <authentication>
                <api_id>'.$this->config->get('sentir_dropship_api_id').'</api_id>
                <api_key>'.$this->config->get('sentir_dropship_api_key').'</api_key>
                <mode>'.($this->config->get('sentir_dropship_status') ? 'production' : null).'</mode>
            </authentication>
            <method>getCategories</method>
        </request>';

        $postfields = $post_string;

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_TIMEOUT, 60);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $postfields);

        $obj = curl_exec($ch);

        $res = json_decode($obj);

        if (curl_errno($ch)){
            $json['error'] = $this->language->get('error_connection');
        }

        if ($res->code == 401){
            $json['error'] = $res->status;
        }

        if (!$json) {
            $json['success'] = $this->language->get('text_success');

            $this->load->model('feed/sentir_dropship');

            // Get the contents of the uploaded file
            $content = $res->CategoryObj;

            $this->model_feed_sentir_dropship->import($content);

        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function setInventory(){

        $json = array();

        $type = $this->request->get['type'];

        if (isset($this->request->post['category_id'])){
            $category_id = $this->request->post['category_id'];
        } else{
            $category_id = $this->request->get['category_id'];
        }

        if (isset($this->request->post['selected'])) {
            $this->product_selection = $this->request->post['selected'];
        } else {
            $this->product_selection = array();
        }

        $json[] = $this->product_selection;

        $this->load->model('feed/sentir_dropship');

        $local_category_id = $this->model_feed_sentir_dropship->getLocalCategoryBySourceCategoryId($category_id);

            $this->model_feed_sentir_dropship->setInventory($this->product_selection,$type,$local_category_id);

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function removeInventory(){

        $json = array();

        $product_id = $this->request->post['product_id'];

        $this->load->model('feed/sentir_dropship');

        $this->model_feed_sentir_dropship->removeInventory($product_id);

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function getInventory(){

        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }

        $filter_data = array(
            'start' => ($page - 1) * $this->config->get('config_limit_admin'),
            'limit' => $this->config->get('config_limit_admin')
        );

        $this->load->model('feed/sentir_dropship');

        $data['inventory'] = $this->model_feed_sentir_dropship->getInventory($filter_data);
        $data['inv_products'] = array();

        foreach ($data['inventory'] as $product){

            //Connect To API

            $url = $this->config->get('sentir_dropship_end_point');

            $post_string = '<?xml version="1.0" encoding="UTF-8"?>
        <request>
            <authentication>
                <api_id>'.$this->config->get('sentir_dropship_api_id').'</api_id>
                <api_key>'.$this->config->get('sentir_dropship_api_key').'</api_key>
                <mode>'.($this->config->get('sentir_dropship_status') ? 'production' : null).'</mode>
            </authentication>
            <method>getProduct</method>
            <product_id>'.$product.'</product_id>
        </request>';

            $postfields = $post_string;

            $ch = curl_init();
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
            curl_setopt($ch, CURLOPT_URL, $url);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
            curl_setopt($ch, CURLOPT_TIMEOUT, 60);
            curl_setopt($ch, CURLOPT_POSTFIELDS, $postfields);

            $obj = curl_exec($ch);

            $res = json_decode($obj);

            $data['inv_products'][] = $res->ProductObj;
        }



        $data['token'] = $this->session->data['token'];

        $data['currency']=$this->currency;

        $total_inventory = count($this->model_feed_sentir_dropship->getInventory());

        $pagination = new Pagination();
        $pagination->total = ($total_inventory ? $total_inventory : 0);
        $pagination->page = $page;
        $pagination->limit = $this->config->get('config_limit_admin');
        $pagination->url = $this->url->link('feed/sentir_dropship/getInventory', 'token=' . $this->session->data['token'] . '&page={page}' , 'SSL');

        $data['pagination'] = $pagination->render();

        $data['results'] = sprintf($this->language->get('text_pagination'), ((isset($total_inventory) ? $total_inventory : 0)) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ((isset($total_inventory) ? $total_inventory : 0) - $this->config->get('config_limit_admin'))) ? (isset($total_inventory) ? $total_inventory : 0) : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), (isset($total_inventory) ? $total_inventory : 0), ceil((isset($total_inventory) ? $total_inventory : 0) / $this->config->get('config_limit_admin')));


        $this->response->setOutput($this->load->view('feed/sentir_dropship_inventory.tpl', $data));
    }

    public function getProducts(){

        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }

        $this->load->model('feed/sentir_dropship');

        $selected = $this->model_feed_sentir_dropship->getInventory();

        if ($selected){
            $data['selected'] = $selected;
        } else {
            $data['selected'] = array();
        }



        $data['currency']=$this->currency;

        if (isset($this->request->post['category_id'])){
            $category_id = $this->request->post['category_id'];
        } else{
            $category_id = $this->request->get['category_id'];
        }

        //Connect To API

        $url = $this->config->get('sentir_dropship_end_point');

        $post_string = '<?xml version="1.0" encoding="UTF-8"?>
        <request>
            <authentication>
                <api_id>'.$this->config->get('sentir_dropship_api_id').'</api_id>
                <api_key>'.$this->config->get('sentir_dropship_api_key').'</api_key>
                <mode>'.($this->config->get('sentir_dropship_status') ? 'production' : null).'</mode>
            </authentication>
            <method>getProducts</method>
            <category_id>'.$category_id.'</category_id>
            <page>'.$page.'</page>
        </request>';

        $postfields = $post_string;

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_TIMEOUT, 60);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $postfields);

        $obj = curl_exec($ch);

        $res = json_decode($obj);

        $data['products']=$res;

        $data['token'] = $this->session->data['token'];

        $pagination = new Pagination();
        $pagination->total = (isset($res->total_products) ? $res->total_products : 0);
        $pagination->page = $page;
        $pagination->limit = $this->config->get('config_limit_admin');
        $pagination->url = $this->url->link('feed/sentir_dropship/getProducts', 'token=' . $this->session->data['token'] . '&page={page}&category_id=' .$category_id, 'SSL');

        $data['pagination'] = $pagination->render();

        $data['results'] = sprintf($this->language->get('text_pagination'), ((isset($res->total_products) ? $res->total_products : 0)) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ((isset($res->total_products) ? $res->total_products : 0) - $this->config->get('config_limit_admin'))) ? (isset($res->total_products) ? $res->total_products : 0) : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), (isset($res->total_products) ? $res->total_products : 0), ceil((isset($res->total_products) ? $res->total_products : 0) / $this->config->get('config_limit_admin')));



        $this->response->setOutput($this->load->view('feed/sentir_dropship_products.tpl', $data));

    }
    public function getCategories(){

        $this->load->language('feed/sentir_dropship');

        $data['text_no_results'] = $this->language->get('text_no_results');
        $data['text_loading'] = $this->language->get('text_loading');

        $data['column_sentir_category'] = $this->language->get('column_sentir_category');
        $data['column_category'] = $this->language->get('column_category');
        $data['column_action'] = $this->language->get('column_action');

        $data['button_add'] = $this->language->get('button_add');

        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }

        $data['sentir_dropship_categories'] = array();

        $this->load->model('feed/sentir_dropship');

        $filter_data= array(
            'start' => ($page - 1) * $this->config->get('config_limit_admin'),
            'limit' => $this->config->get('config_limit_admin')
        );

        $results = $this->model_feed_sentir_dropship->getLocalCategories($filter_data);

        foreach ($results as $result) {
            $data['sentir_dropship_categories'][] = array(
                'category_id' => $result['sentir_dropship_category_id'],
                'name'    => $result['name'],
            );
        }

        $category_total = $this->model_feed_sentir_dropship->getTotalLocalCategories();

        $pagination = new Pagination();
        $pagination->total = $category_total;
        $pagination->page = $page;
        $pagination->limit = $this->config->get('config_limit_admin');;
        $pagination->url = $this->url->link('feed/sentir_dropship/getCategories', 'token=' . $this->session->data['token'] . '&page={page}', 'SSL');

        $data['pagination'] = $pagination->render();

        $data['results'] = sprintf($this->language->get('text_pagination'), ($category_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($category_total - $this->config->get('config_limit_admin'))) ? $category_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $category_total, ceil($category_total / $this->config->get('config_limit_admin')));

        $this->response->setOutput($this->load->view('feed/sentir_dropship_main_category.tpl', $data));


    }
    public function category() {
        $this->load->language('feed/sentir_dropship');

        $data['text_no_results'] = $this->language->get('text_no_results');
        $data['text_loading'] = $this->language->get('text_loading');

        $data['column_sentir_category'] = $this->language->get('column_sentir_category');
        $data['column_category'] = $this->language->get('column_category');
        $data['column_action'] = $this->language->get('column_action');

        $data['button_remove'] = $this->language->get('button_remove');

        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }

        $data['sentir_dropship_categories'] = array();

        $this->load->model('feed/sentir_dropship');

        $results = $this->model_feed_sentir_dropship->getCategories(($page - 1) * 10, 10);

        foreach ($results as $result) {
            $data['sentir_dropship_categories'][] = array(
                'sentir_dropship_category_id' => $result['sentir_dropship_category_id'],
                'sentir_dropship_category'    => $result['sentir_dropship_category'],
                'category_id'             => $result['category_id'],
                'category'                => $result['category']
            );
        }

        $category_total = $this->model_feed_sentir_dropship->getTotalCategories();

        $pagination = new Pagination();
        $pagination->total = $category_total;
        $pagination->page = $page;
        $pagination->limit = 10;
        $pagination->url = $this->url->link('feed/sentir_dropship/category', 'token=' . $this->session->data['token'] . '&page={page}', 'SSL');

        $data['pagination'] = $pagination->render();

        $data['results'] = sprintf($this->language->get('text_pagination'), ($category_total) ? (($page - 1) * 10) + 1 : 0, ((($page - 1) * 10) > ($category_total - 10)) ? $category_total : ((($page - 1) * 10) + 10), $category_total, ceil($category_total / 10));

        $this->response->setOutput($this->load->view('feed/sentir_dropship_category.tpl', $data));
    }

    public function categorylocalized() {
        $this->load->language('feed/sentir_dropship');

        $data['text_no_results'] = $this->language->get('text_no_results');
        $data['text_loading'] = $this->language->get('text_loading');

        $data['column_sentir_category'] = $this->language->get('column_sentir_category');
        $data['column_category'] = $this->language->get('column_category');
        $data['column_action'] = $this->language->get('column_action');

        $data['button_remove'] = $this->language->get('button_remove');

        $data['token'] = $this->session->data['token'];

        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }

        $data['sentir_dropship_categories'] = array();

        $this->load->model('feed/sentir_dropship');

        $results = $this->model_feed_sentir_dropship->getCategories(($page - 1) * 10, 10);

        foreach ($results as $result) {
            $data['sentir_dropship_categories'][] = array(
                'sentir_dropship_category_id' => $result['sentir_dropship_category_id'],
                'sentir_dropship_category'    => $result['sentir_dropship_category'],
            );
        }

        $category_total = $this->model_feed_sentir_dropship->getTotalCategories();

        $pagination = new Pagination();
        $pagination->total = $category_total;
        $pagination->page = $page;
        $pagination->limit = 10;
        $pagination->url = $this->url->link('feed/sentir_dropship/category', 'token=' . $this->session->data['token'] . '&page={page}', 'SSL');

        $data['pagination'] = $pagination->render();

        $data['results'] = sprintf($this->language->get('text_pagination'), ($category_total) ? (($page - 1) * 10) + 1 : 0, ((($page - 1) * 10) > ($category_total - 10)) ? $category_total : ((($page - 1) * 10) + 10), $category_total, ceil($category_total / 10));

        $this->response->setOutput($this->load->view('feed/sentir_dropship_category_localized.tpl', $data));
    }

    public function addCategory() {
        $this->load->language('feed/sentir_dropship');

        $json = array();

        if (!$this->user->hasPermission('modify', 'sale/order')) {
            $json['error'] = $this->language->get('error_permission');
        } elseif (!empty($this->request->post['sentir_dropship_category_id']) && !empty($this->request->post['category_id'])) {
            $this->load->model('feed/sentir_dropship');

            $this->model_feed_sentir_dropship->addCategory($this->request->post);

            $json['success'] = $this->language->get('text_success');
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function removeCategory() {
        $this->load->language('feed/sentir_dropship');

        $json = array();

        if (!$this->user->hasPermission('modify', 'sale/order')) {
            $json['error'] = $this->language->get('error_permission');
        } else {
            $this->load->model('feed/sentir_dropship');

            $this->model_feed_sentir_dropship->deleteCategory($this->request->post['category_id']);

            $json['success'] = $this->language->get('text_success');
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function autocomplete() {
        $json = array();

        if (isset($this->request->get['filter_name'])) {
            $this->load->model('feed/sentir_dropship');

            if (isset($this->request->get['filter_name'])) {
                $filter_name = $this->request->get['filter_name'];
            } else {
                $filter_name = '';
            }

            $filter_data = array(
                'filter_name' => html_entity_decode($filter_name, ENT_QUOTES, 'UTF-8'),
                'start'       => 0,
                'limit'       => 5
            );

            $results = $this->model_feed_sentir_dropship->getSentirDropshipCategories($filter_data);

            foreach ($results as $result) {
                $json[] = array(
                    'sentir_dropship_category_id' => $result['sentir_dropship_category_id'],
                    'name'                    => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8'))
                );
            }
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
}