<?php

if ( ! defined('DIR_APPLICATION')) exit('No direct script access allowed');
    
 /**
 * Sentir Development
 *
 * @category   adelaonline
 * @package    Payment Gateway
 * @copyright  Copyright 2014-2015 Sentir Development
 * @license    http://www.sentir-development.com/license/
 * @version    1.0.15.10
 * @author     Ahmet GOUDENOGLU <ahmet.gudenoglu@sentir-development.com>
 */
class ControllerModuleSentirCategoryProduct extends Controller {
    public function index($setting) {


        $this->load->language('module/sentir_category_product');

        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_tax'] = $this->language->get('text_tax');

        $data['button_cart'] = $this->language->get('button_cart');
        $data['button_wishlist'] = $this->language->get('button_wishlist');
        $data['button_compare'] = $this->language->get('button_compare');

        $this->load->model('catalog/product');

        $this->load->model('tool/image');

        $data['products'] = array();

        if (isset($this->request->get['filter'])) {
            $filter = $this->request->get['filter'];
        } else {
            $filter = '';
        }

        if (isset($this->request->get['sort'])) {
            $sort = $this->request->get['sort'];
        } else {
            $sort = 'p.sort_order';
        }

        if (isset($this->request->get['order'])) {
            $order = $this->request->get['order'];
        } else {
            $order = 'ASC';
        }

        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }

        if (isset($this->request->get['limit'])) {
            $limit = (int)$this->request->get['limit'];
        } else {
            $limit = $this->config->get('config_product_limit');
        }


        $url = '';

        if (isset($this->request->get['sort'])) {
            $url .= '&sort=' . $this->request->get['sort'];
        }

        if (isset($this->request->get['order'])) {
            $url .= '&order=' . $this->request->get['order'];
        }

        if (isset($this->request->get['limit'])) {
            $url .= '&limit=' . $this->request->get['limit'];
        }

        $data['categories'] = array();
        $cat_collection = array();

        $results = $this->model_catalog_category->getCategories($this->getCurrentCatetgoryID());

        foreach ($results as $result) {
            $filter_data = array(
                'filter_category_id'  => $result['category_id'],
                'filter_sub_category' => true
            );

            $cat_collection[] = $result['category_id'];


        }

        foreach ($cat_collection as $rootCat){

            $collection[] = $this->getSubCategories($rootCat);

        }

        $collection_count = count($collection);
        $sub_categories= array();

        for ($Count = 0; $Count <= $collection_count - 1; $Count++) {

            foreach($collection[$Count] as $cat_id){

                $sub_categories[] = $cat_id;
            }
        }

        $check_product = $this->model_catalog_product->getProducts(array('filter_category_id'  => $this->getCurrentCatetgoryID()));

        if (!$check_product){

            $filter_data = array(
                'filter_category_id'  => $this->getCurrentCatetgoryID(),
                'filter_sub_category' => true,
                'filter_filter'      => $filter,
                'collection'        => implode(',',$sub_categories),
                'sort'               => $sort,
                'order'              => $order,
                'start'              => ($page - 1) * $limit,
                'limit'              => $limit
            );

            $product_total = $this->model_catalog_product->getTotalProducts($filter_data);

            $results = $this->model_catalog_product->getProducts($filter_data);

            if ($results) {
                foreach ($results as $result) {
                    if ($result['image']) {
                        $image = $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height']);
                    } else {
                        $image = $this->model_tool_image->resize('placeholder.png', $setting['width'], $setting['height']);
                    }

                    if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                        $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
                    } else {
                        $price = false;
                    }

                    if ((float)$result['special']) {
                        $special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
                    } else {
                        $special = false;
                    }

                    if ($this->config->get('config_tax')) {
                        $tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
                    } else {
                        $tax = false;
                    }

                    if ($this->config->get('config_review_status')) {
                        $rating = $result['rating'];
                    } else {
                        $rating = false;
                    }

                    $data['products'][] = array(
                        'product_id'  => $result['product_id'],
                        'thumb'       => $image,
                        'name'        => $result['name'],
                        'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
                        'price'       => $price,
                        'special'     => $special,
                        'tax'         => $tax,
                        'rating'      => $rating,
                        'href'        => $this->url->link('product/product', 'product_id=' . $result['product_id'])
                    );
                }

                $pagination = new Pagination();
                $pagination->total = $product_total;
                $pagination->page = $page;
                $pagination->limit = $limit;
                $pagination->url = $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&page={page}');

                $data['pagination'] = $pagination->render();

                $data['results'] = sprintf($this->language->get('text_pagination'), ($product_total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($product_total - $limit)) ? $product_total : ((($page - 1) * $limit) + $limit), $product_total, ceil($product_total / $limit));

                $data['sort'] = $sort;
                $data['order'] = $order;
                $data['limit'] = $limit;

                if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/sentir_category_product.tpl')) {
                    return $this->load->view($this->config->get('config_template') . '/template/module/sentir_category_product.tpl', $data);
                } else {
                    return $this->load->view('default/template/module/sentir_category_product.tpl', $data);
                }
            }

        }

    }

    protected function getSubCategories($rootCat){

        $cat_ids = array();

        $this->load->model('catalog/category');

        $results = $this->model_catalog_category->getCategories($rootCat);

        foreach ($results as $result){

            $cat_ids[] = $result['category_id'];
        }

        return $cat_ids;

    }

    protected function getCurrentCatetgoryID(){
        if(isset($this->request->get['path'])) {
            $path = $this->request->get['path'];
            $cats = explode('_', $path);
            $cat_id = $cats[count($cats) - 1];
            return  $cat_id;
        }
    }
}

 /* End of file sentir_category_product.php */  