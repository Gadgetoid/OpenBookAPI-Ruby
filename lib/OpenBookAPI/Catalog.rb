module OpenBookAPI

  class Content
    @type_id = nil
    @type_desc = nil

    @content = [
        :area1 => nil,
        :area2 => nil,
        :area3 => nil
    ] # area1, area2, area3

    attr_accessor :type_id, :type_desc, :content
  end

  class Product

    attr_accessor :id, :title, :sub_title,
                  :on_sale_date, :release_date,
                  :isbn,
                  :format, :sub_format,
                  :imprint, :editorial_imprint,
                  :group_id, :group_seo_copy, :group_title,
                  :series, :price, :number_of_pages, :volume,
                  :ages, :min_age, :max_age, :reading_level,
                  :grade_start, :grade_end,
                  :catalog_name,
                  :best_seller, :new_release, :future_release,
                  :number_of_reviews, :sales_marketing_code, :business_unit,
                  :essays, :locale, :contents, :contributor_names, :bisac_codes, :categories,
                  :author, :co_author, :artist,
                  :cover_image

    @id = nil
    @title = nil         # Product_Group > Product > Title
    @sub_title = nil
    @on_sale_date = nil  # Product_Group > Product > On_Sale_Date
    @release_date = nil
    @isbn = nil          # Prouduct_Group > Product > ISBN
    @format = nil
    @sub_format = nil
    @imprint = nil
    @editorial_imprint = nil

    @group_id = nil
    @group_seo_copy = nil
    @group_title = nil

    @series = nil

    @price = nil
    @number_of_pages = nil
    @volume = nil

    @ages = []
    @min_age = nil
    @max_age = nil
    @reading_level = nil

    @grade_start = nil
    @grade_end = nil

    @catalog_name = nil

    # Flags stored as 0 or 1 in API
    @best_seller = nil
    @new_release = nil
    @future_release = nil

    @number_of_reviews = nil
    @sales_marketing_code = nil
    @business_unit = nil

    @essays = nil
    @locale = nil

    @contents = []

    @contributor_names = nil

    @bisac_codes = nil
    @categories = []

    @author = [
        :id => nil,
        :contributor_persona_id => nil,
        :source_contributor_id => nil
    ]
    @co_author = [
        :id => nil,
        :contributor_persona_id => nil,
        :source_contributor_id => nil
    ]
    @artist = [
        :id => nil,
        :contributor_persona_id => nil,
        :source_contributor_id => nil
    ]
    @cover_image = [
        :large => nil,
        :medium_large => nil,
        :medium => nil,
        :small => nil
    ]

    def initialize

    end

    def self.from_id(book_id)
      source_url = OpenBookAPI::Config.product_by_id(book_id)
      from_url(source_url)
    end

    def self.from_isbn(book_isbn)
      from_url(source_url)
    end

    def self.from_url(source_url)
      product = Product.new()
      source_xml = ''
      product.from_xml(source_xml)
      return product
    end

    def from_xml

    end

  end

  class Product_Group

    attr_accessor :locale_desc, :id, :seo_copy, :title, :products

    @locale_desc = nil
    @id = nil
    @seo_copy = nil # Product_Group_SEO_Copy
    @title = nil # Product_group_title
    @products = []

    def initialize

    end

    def from_json(source_json)

    end

    def from_xml(source_xml)

    end

    end

end