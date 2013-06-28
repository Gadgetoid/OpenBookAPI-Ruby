module OpenBookAPI

	class Contributor
		@display_name = nil
		@first_name = nil
		@middle_name = nil
		@last_name = nil
		@role = nil
		@order = nil
		@id = nil

		attr_accessor :display_name, :first_name, :middle_name,
					  :last_name, :role, :order, :id
	end

	class Category
		@category_desc = nil
		@category_type_desc = nil

		attr_accessor :category_desc, :category_type_desc
	end

	class Content

		def initialize
			@type_id = nil
			@type_desc = nil

			@content = [
					:area1 => nil,
					:area2 => nil,
					:area3 => nil
			] # area1, area2, area3
		end

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
					  :essays, :locale, :contents, :contributors, :bisac_codes, :categories,
					  :author, :co_author, :artist,
					  :cover_image

		@id = nil
		@title = nil # Product_Group > Product > Title
		@sub_title = nil
		@on_sale_date = nil # Product_Group > Product > On_Sale_Date
		@release_date = nil
		@isbn = nil # Prouduct_Group > Product > ISBN
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

		@bisac_codes = nil
		@categories = []

		@contributors = []

		@cover_image = [
				:large => nil,
				:medium_large => nil,
				:medium => nil,
				:small => nil
		]

		def initialize(product_id)
			@id = product_id
			@contents = []
			@contributors = []
			@categories = []
		end

		def self.from_id(api,product_id)
			source_url = OpenBookAPI::Helpers.product_by_id(api, product_id)
			puts 'Requesting from ' + source_url
			product = Product.new(product_id)
			source_xml = REXML::Document.new(Net::HTTP.get_response(URI.parse(source_url)).body)
			product.from_xml(source_xml)
			return product
		end

		def self.from_isbn(api, book_isbn)
			from_url(source_url)
		end

		def from_xml(source_xml)
			xml = source_xml.get_elements('/OpenBook_API/Product_Detail/')[0]
			#puts xml

			self.title = xml.get_text('Title')
			self.sub_title = xml.get_text('Subtitle')

			self.on_sale_date =  xml.get_text('On_Sale_Date')
			self.release_date =  xml.get_text('Release_Date')
			self.isbn =  xml.get_text('ISBN')
			self.format =  xml.get_text('Format')
			self.sub_format =  xml.get_text('Sub_Format')
			self.imprint =  xml.get_text('Imprint')
			self.editorial_imprint =  xml.get_text('Editorial_Imprint')
			self.group_id =  xml.get_text('Product_Group_ID')
			self.group_seo_copy =  xml.get_text('Product_Group_SEO_Copy')
			self.group_title =  xml.get_text('Product_Group_Title')
			self.series =  xml.get_text('Series')
			self.price =  Float(xml.get_text('Price').to_s)
			self.number_of_pages =  Integer(xml.get_text('Num_Of_Pages').to_s)
			self.volume =  xml.get_text('Volume')
			self.ages =  xml.get_text('Ages')
			self.min_age =  xml.get_text('Min_Age')
			self.max_age =  xml.get_text('Max_Age')
			self.reading_level =  xml.get_text('Reading_Level')
			self.grade_start =  xml.get_text('Grade_Start')
			self.grade_end =  xml.get_text('Grade_End')
			self.catalog_name =  xml.get_text('Catalog_Name')
			self.best_seller =  xml.get_text('Best_Seller_Flag') == '1'
			self.new_release =  xml.get_text('Future_Release_Flag') == '1'
			self.future_release =  xml.get_text('New_Release_Flag') == '1'
			self.number_of_reviews =  Integer(xml.get_text('No_of_Reviews').to_s)
			self.sales_marketing_code =  xml.get_text('Sales_Marketing_Code')
			self.business_unit =  xml.get_text()
			self.essays =  xml.get_text('Has_Essay')
			self.locale =  xml.get_text('Locale_Desc')

			xml.each_element('Product_Contents/Product_Content') do |content|
				c = OpenBookAPI::Content.new()
				c.type_id = Integer(content.get_text('Content_Type_ID').to_s)
				c.type_desc = content.get_text('Content_Type_Desc')
			    c.content = [:area1 => content.get_text('Content_Area1'),
						  :area2 => content.get_text('Content_Area2'),
						  :area3 => content.get_text('Content_Area3')]
				self.contents << c
			end

			self.bisac_codes =  xml.get_text()

			xml.each_element('Product_Categories/Product_Category') do |category|
		    	c = OpenBookAPI::Category.new()
				c.category_type_desc = category.get_text('Category_Type_Desc')
				c.category_desc = category.get_text('Category_Desc')
				self.categories << c
			end

			xml.each_element('Product_Contributors/Product_Contributor') do |contributor|
				c = OpenBookAPI::Contributor.new()
				c.display_name = contributor.get_text('Display_Name')
				c.first_name = contributor.get_text('First_Name')
				c.middle_name = contributor.get_text('Middle_Name')
				c.last_name = contributor.get_text('Last_Name')
				c.role = contributor.get_text('Role')
				c.id = Integer(contributor.get_text('Contributor_Persona_ID').to_s)
				self.contributors[Integer(contributor.get_text('Contributor_Order').to_s)] = c
			end

			self.cover_image = [
					:large => xml.get_text('CoverImageURL_Large'),
					:medium_large => xml.get_text('CoverImageURL_MediumLarge'),
					:medium => xml.get_text('CoverImageURL_Medium'),
					:small => xml.get_text('CoverImageURL_Small')
			]
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