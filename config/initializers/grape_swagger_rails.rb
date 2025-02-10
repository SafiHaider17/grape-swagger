# # config/initializers/grape_swagger_rails.rb
# GrapeSwaggerRails.options.app_name = 'My API'
# GrapeSwaggerRails.options.url = '/swagger_doc' # URL for Swagger JSON
# GrapeSwaggerRails.options.api_auth = 'Bearer {your-token}'  # Optional, if you want to add authorization
GrapeSwaggerRails.options.url      = '/swagger_doc'  # ✅ Correct Swagger JSON URL
GrapeSwaggerRails.options.app_name = 'My API'
GrapeSwaggerRails.options.app_url  = 'http://localhost:3000'  # ✅ Ensure correct base URL
GrapeSwaggerRails.options.api_auth = 'basic'  # 🔐 Basic Auth Enable karein
