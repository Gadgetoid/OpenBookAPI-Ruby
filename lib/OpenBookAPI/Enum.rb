module OpenBookAPI

  format = [
    :audio => "Audio",
    :digest => "Digest"
  Digital_Audio = "Digital Audio"
  Downloadable_Audio = "Downloadable audio"
  E_Book = "E-Book"
  Electronic_book_text = "Electronic book text"
  Hardback = "Hardback"
  Hardcover = "Hardcover"
  Large_Print = "Large Print"
  Leather = "Leather"
  Mass_Market_PB = "Mass Market PB"
  Merchandise = "Merchandise"
  Paperback = "Paperback"
  Trade_PB = "Trade PB"

  ]

  class API
    attr_accessor :api_key, :base_url
    @api_key = ''
    @base_url = 'http://api.harpercollins.com/api/v3/hcapim'

    def get_product_by_id(product_id)
      product = OpenBookAPI::Product.from_url(OpenBookAPI::Helpers.product_by_id(self,product_id))
    end
  end

  class Helpers
    def self.product_by_id(api,id)
      return "#{api.base_url}?apiname=ProductInfo%20&format=XML&productID=#{id}&apikey=#{api.api_key}"
    end
  end


end