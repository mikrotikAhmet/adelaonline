<?php 
error_reporting(E_ALL);
ini_set('display_errors', 1);
class PtsWidgetProduct_popular extends PtsWidgetPageBuilder {

		public $name = 'product_popular';
		public $group = 'opencart';
		
		public static function getWidgetInfo(){
			return  array('label' => ('Popular Products'), 'explain' => 'Alow show list products type Popular', 'group' => 'opencart'  ) ;
		}
		public function renderForm( $args, $data ){

			$helper = $this->getFormHelper();

			$this->fields_form[1]['form'] = array(
				'legend' => array(
					'title' => $this->l('Widget Config'),
				),
				'input' => array(
					array(
						'type'  => 'text',
						'label' => $this->l('Limit'),
						'name'  => 'limit',
						'default'=> 8,
					),
					array(
						'type'  => 'text',
						'label' => $this->l('Items'),
						'name'  => 'items',
						'default'=> 4,
						'description' => 'input number show items per page.',
					),
					array(
						'type'  => 'text',
						'label' => $this->l('Columns'),
						'name'  => 'cols',
						'default'=> 2,
					),
					array(
						'type'  => 'text',
						'label' => $this->l('width'),
						'name'  => 'width',
						'default'=> 200,
					),
					array(
						'type'  => 'text',
						'label' => $this->l('height'),
						'name'  => 'height',
						'default'=> 200,
					),
				),
				'submit' => array(
					'title' => $this->l('Save'),
					'class' => 'button'
				)
			);
			$default_lang = (int)$this->config->get('config_language_id');
			
			$helper->tpl_vars = array(
				'fields_value' => $this->getConfigFieldsValues( $data  ),
				'id_language' => $default_lang
			);
			return $helper->generateForm( $this->fields_form );
		}

		public function renderContent( $args, $setting ){
			$this->language->load('module/themecontrol');

			

			$languageID = $this->config->get('config_language_id');
			$setting['heading_title'] = isset($setting['widget_title_'.$languageID])?$setting['widget_title_'.$languageID]:'';
			
			// SETTINGS
			$t  = array(
				'limit'      => 8,
				'items'      => 4,
				'cols'       => 1,
				'width'      => 200,
				'height'     => 200,
			);
			$setting = array_merge( $t, $setting );
			
			// DATA
			$setting['products'] = $this->getProducts($setting);

			$output = array('type'=>'products','data' => $setting );
			return $output;
		}

		public function getProducts($setting){
			$data = array();

			$this->load->model('catalog/product');
			$this->load->model('tool/image');

			$query = $this->db->query("SELECT p.product_id FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "' ORDER BY p.viewed DESC LIMIT " . (int)$setting['limit']);
		
			foreach ($query->rows as $result) { 		
				$product_data[$result['product_id']] = $this->model_catalog_product->getProduct($result['product_id']);
			}
						 	 		
			$results = $product_data;
			
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
									
					$data[] = array(
						'product_id'   => $result['product_id'],
						'thumb'   	   => $image,
						'name'         => $result['name'],
						'description'  => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
						'price'   	   => $price,
						'special' 	   => $special,
						'tax'          => $tax,
						'rating'       => $rating,
						'href'         => $this->url->link('product/product', 'product_id=' . $result['product_id']),
					);
				}
			}
			return $data;
		}
	}
?>