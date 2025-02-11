module Api
  class Base < Grape::API
    format :json

    # Basic Authentication Middleware
    http_basic do |username, password|
      username == 'admin' && password == 'password'    
    end

    resource :products do
      desc 'Returns a list of products'
      get do
        Product.all
        #Product.all.pluck(:name, :price, :size , :color)
      end

      desc 'Returns a product by ID'
      params do
        requires :id, type: Integer, desc: 'Product ID'
      end
      get ':id' do  # Fixed route
        product = Product.find_by(id: params[:id])
        error!('Product not found', 404) unless product
        product
      end

      desc 'Creates a new product'
      params do
        requires :name, type: String, desc: 'Product Name'
        requires :price, type: Integer, desc: 'Product Price'
        requires :size, type: Array[String], desc: 'Product Sizes (Array of Strings)'
        requires :color, type: Array[String], desc: 'Product Colors (Array of Strings)'
      end
      post do
        product = Product.create(
          name: params[:name],
          price: params[:price],
          size: params[:size],  # Fixed missing comma
          color: params[:color]  # Fixed missing comma
        )
        if product.persisted?
          product
        else
          error!(product.errors.full_messages, 400)
        end
      end

      desc 'Updates a product'
      params do
        requires :id, type: Integer, desc: 'Product ID'
        requires :name, type: String, desc: 'Product Name'
        requires :price, type: Integer, desc: 'Product Price'
        optional :size, type: Array[String], desc: 'Product Sizes (Array of Strings)'
        optional :color, type: Array[String], desc: 'Product Colors (Array of Strings)'
      end
      put ':id' do
        product = Product.find_by(id: params[:id]) || error!('Product not found', 404)
        product.update!(declared(params, include_missing: false))
        product
      end

      desc 'Partially updates a product'
      params do
        requires :id, type: Integer, desc: 'Product ID'
        optional :name, type: String, desc: 'Product Name'
        optional :price, type: Integer, desc: 'Product Price'
        optional :size, type: Array[String], desc: 'Product Sizes (Array of Strings)'
        optional :color, type: Array[String], desc: 'Product Colors (Array of Strings)'
      end
      patch ':id' do
        product = Product.find_by(id: params[:id]) || error!('Product not found', 404)
        product.update!(declared(params, include_missing: false))
        product
      end

      desc 'Deletes a product'
      params do
        requires :id, type: Integer, desc: 'Product ID'
      end
      delete ':id' do
        product = Product.find_by(id: params[:id]) || error!('Product not found', 404)
        product.destroy
        { message: 'Product deleted successfully' }
      end
    end

    # Swagger Documentation
    add_swagger_documentation(
      info: {
        title: 'My Grape API',
        description: 'API with authentication'
      },
      base_path: '/',
      security_definitions: {
        basic_auth: {
          type: 'basic'
        }
      }
    )
  end
end
