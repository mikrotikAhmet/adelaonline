<?php 
class PtsWidgetProduct_cols extends PtsWidgetPageBuilder {

		public $name = 'product_cols';
		public $group = 'product';
		
		public static function getWidgetInfo(){
			return array('label' => ('Products List'), 'explain' => 'Created Product-Cols List by ID', 'group' => 'opencart'  );
		}


		public function renderForm( $args, $data ){

			$helper = $this->getFormHelper();
 

			$this->fields_form[1]['form'] = array(
	            'legend' => array(
	                'title' => $this->l('Widget Form.'),
	            ),
	            'input' => array(
	                array(
	                    'type'  => 'text',
	                    'label' => $this->l('First Product ID'),
	                    'name'  => 'first_id',
	                    'default'=> 1,
	                ),
	                array(
	                    'type'  => 'text',
	                    'label' => $this->l('Product List ID'),
	                    'name'  => 'list_id',
	                    'default'=> "33,34,35,36",
	                ),
	                array(
	                    'type'  => 'text',
	                    'label' => $this->l('Limit'),
	                    'name'  => 'limit',
	                    'default'=> 8,
	                ),
	                array(
	                    'type'  => 'text',
	                    'label' => $this->l('Width'),
	                    'name'  => 'image_width',
	                    'default'=> 200,
	                    'desc'	=> '',
	                ),
	                array(
	                    'type'  => 'text',
	                    'label' => $this->l('Height'),
	                    'name'  => 'image_height',
	                    'default'=> 200,
	                    'desc'	=> '',
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


			return  $helper->generateForm( $this->fields_form );
		}

		private function getFirstProduct( $setting ){
			$this->load->model('catalog/product');
			$this->load->model('tool/image');
			$data = array();

			$ID = $setting['first_id'];

			$result = $this->model_catalog_product->getProduct( $ID );

			if(!empty($result)) { 

				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], 270, 270);
				} else {
					$image = $this->model_tool_image->resize('placeholder.png', $setting['image_width'], $setting['image_height']);
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
					$rating = (int)$result['rating'];
				} else {
					$rating = false;
				}

				$data = array(
					'product_id'  => $result['product_id'],
					'thumb'       => $image,
					'name'        => $result['name'],
					'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
					'price'       => $price,
					'special'     => $special,
					'tax'         => $tax,
					'rating'      => $result['rating'],
					'href'        => $this->url->link('product/product', 'product_id=' . $result['product_id'])
				);
			}
			
			return $data;
		}

		private function getProducts( $setting ){
			$this->load->model('catalog/product');
			$this->load->model('tool/image');
			$data = array();

			$listID = explode(",", $setting['list_id']);

			foreach ($listID as $id) {

				$result = $this->model_catalog_product->getProduct( $id );

				if(!empty($result)) {

					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $setting['image_width'], $setting['image_height']);
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $setting['image_width'], $setting['image_height']);
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
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}

					$data[] = array(
						'product_id'  => $result['product_id'],
						'thumb'       => $image,
						'name'        => $result['name'],
						'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
						'price'       => $price,
						'special'     => $special,
						'tax'         => $tax,
						'rating'      => $result['rating'],
						'href'        => $this->url->link('product/product', 'product_id=' . $result['product_id'])
					);
				}
			}
			return $data;
		}

		public function renderContent(  $args, $setting ) {

			$t  = array(
				'first_id'      => '33',
				'list_id'		=> "33,34,35,36",
				'limit'         => '8',
				'itemsperpage'  => '3',
				'cols'          => '1',
				'image_width'   => '200',
				'image_height'  => '200',
			);

			$setting = array_merge( $t, $setting );

			$languageID = $this->config->get('config_language_id');
			$setting['heading_title'] = isset($setting['widget_title_'.$languageID])?$setting['widget_title_'.$languageID]:'';

			// get product by first_id
			$first_product = $this->getFirstProduct( $setting );
			$setting['product'] = $first_product;

			// get all product by list_id
			$products = $this->getProducts( $setting );
			$setting['products'] = $products;


			$output = array('type'=>'products','data' => $setting );

			return $output;
		}	
	}
?>