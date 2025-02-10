# config/routes.rb
Rails.application.routes.draw do
  # Mounting Grape API
  mount Api::Base => '/'

  # Optionally, for Swagger UI
  mount GrapeSwaggerRails::Engine => '/swagger'
end
