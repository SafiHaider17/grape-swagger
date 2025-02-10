Rails.application.routes.draw do
  #Grape API
  mount Api::Base => '/'

  #Swagger UI
  mount GrapeSwaggerRails::Engine => '/api-docs'
end
