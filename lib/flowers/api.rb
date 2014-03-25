require 'savon'
require 'flowers/exception/exceptions'

module Flowers
  class API

    ORDER_WSDL = 'https://www.floristone.com/webservices4/cart.cfc?wsdl'
    SHOP_WSDL  = 'https://www.floristone.com/webservices4/flowershop.cfc?wsdl'

    OPERATIONS = {
                 getProducts: :shop,
                  getProduct: :shop,
            getDeliveryDates: :shop,
           checkDeliveryDate: :shop,
                    getTotal: :shop,
                  placeOrder: :shop,
                getOrderInfo: :shop,
          createShoppingCart: :order,
         addItemShoppingCart: :order,
      removeItemShoppingCart: :order,
             getShoppingCart: :order,
           emptyShoppingCart: :order,
         destroyShoppingCart: :order }

    CATEGORIES = {
        ao: 'everyday',
        bd: 'birthday',
        an: 'anniversary',
        lr: 'love  & romance',
        gw: 'get well',
        nb: 'new baby',
        ty: 'thank you',
        sy: 'sympathy',
         c: 'centerpieces',
         o: 'one sided arrangements',
         n: 'novelty arrangements',
         v: 'vased arrangements',
         r: 'roses',
         q: 'cut bouquets',
         x: 'fruit baskets',
         p: 'plants',
         b: 'balloons',
        fa: 'table arrangements',
        fb: 'baskets',
        fs: 'sprays',
        fp: 'floor plants',
        fl: 'inside casket',
        fw: 'wreaths',
        fh: 'hearts',
        fx: 'crosses',
        fc: 'casket sprays',
      apop: 'all items, sorted by popularity',
       aaz: 'all items, sorted alphabetically',
       apa: 'all items, sorted by price (ascending)',
       apd: 'all items, sorted by price (descending)',
        cm: 'Christmas',
        ea: 'Easter',
        vd: 'Valentines Day',
        md: 'Mothers Day' }


    attr_accessor :shop_client, :order_client

    cattr_accessor :api_key
    cattr_accessor :password

    def initialize
      @shop_client  = Savon.client wsdl: SHOP_WSDL
      @order_client = Savon.client wsdl: ORDER_WSDL
      # @shop_client.operations
      # @order_client.operations
    end

    def get_products(category, num_products = 1000, start_at = 1)
      raise Exception::InvalidCategoryError.new unless CATEGORIES.keys.include?(category.to_sym)
      execute!(:getProducts, category: category.to_s, numProducts: num_products, startAt: start_at)[:products][:products]
    end

    protected

      def execute!(method,parameters={})
        client_type = OPERATIONS[method.to_sym]
        client      = self.send "#{client_type}_client"
        response    = client.call method.to_s.underscore.to_sym, message: default_parameters.merge(parameters)
        response.body["#{method.to_s.underscore}_response".to_sym]["#{method.to_s.underscore}_return".to_sym]
      end

      def default_parameters(others={})
        { apiKey: self.class.api_key, apiPassword: self.class.password }.merge(others)
      end

  end
end
