module OpenBookAPI

  format = [
    :audio => "Audio",
    :digest => "Digest",
	:digital_audio => "Digital Audio",
  	:downloadable_audio => "Downloadable audio",
  	:e_book => "E-Book",
  	:electronic_book_text => "Electronic book text",
  	:hardback => "Hardback",
  	:hardcover => "Hardcover",
  	:large_print => "Large Print",
  	:leather => "Leather",
  	:mass_market_pb => "Mass Market PB",
  	:merchandise => "Merchandise",
  	:paperback => "Paperback",
  	:trade_pb => "Trade PB"
  ]

  class API
    attr_accessor :api_key, :base_url
    @api_key = ''
    @base_url = ''

	def initialize(api_key)

		@api_key = api_key
		@base_url = 'http://api.harpercollins.com/api/v3/hcapim'

	end

    def get_product_by_id(product_id)
      return OpenBookAPI::Product.from_id(self,product_id)
    end
  end

  class Helpers
    def self.product_by_id(api,id)
      return "#{api.base_url}?apiname=ProductInfo%20&format=XML&productID=#{id}&apikey=#{api.api_key}"
    end
  end


end