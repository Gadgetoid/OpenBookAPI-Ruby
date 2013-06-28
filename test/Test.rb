require '../lib/OpenBookAPI'

api = OpenBookAPI::API.new()
api.api_key = 'pn9t4ke7fk2kw4cq8uh4hepf'

my_product = api.get_product_by_id(44863)