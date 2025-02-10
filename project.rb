gem 'grape'
gem 'grape-swagger'
gem 'grape-swagger-rails' # Optional for Swagger UI

bundle install

# app/api/api.rb
module Api
  class Base < Grape::API
    format :json

    desc 'Returns Hello World'
    get :hello do
      { message: 'Hello World from Grape API' }
    end

    # Add swagger documentation
    add_swagger_documentation
  end
end

add this in manifest.js
//= link grape_swagger_rails/application.css
//= link grape_swagger_rails/application.js

# config/routes.rb
Rails.application.routes.draw do
  # Mounting Grape API
  mount Api::Base => '/'

  # Optionally, for Swagger UI
  mount GrapeSwaggerRails::Engine => '/swagger'
end


add this config/initializers/grape_swagger_rails.rb
GrapeSwaggerRails.options.url      = '/swagger_doc'  # ✅ Correct Swagger JSON URL
GrapeSwaggerRails.options.app_name = 'My API'
GrapeSwaggerRails.options.app_url  = 'http://localhost:3000'  # ✅ Ensure correct base URL
GrapeSwaggerRails.options.api_auth = 'basic'  # 🔐 Basic Auth Enable karein