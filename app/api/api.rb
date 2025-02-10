module Api
  class Base < Grape::API
    format :json

    #  Basic Authentication Middleware
    http_basic do |username, password|
      username == 'admin' && password == 'password123'
    end

    #  GET
    desc 'Returns a list of products'
    get :products do
      Product.all
    end

    #  GET BY ID
    desc 'Returns a product by ID'
    params do
      requires :id, type: Integer, desc: 'Product ID'
    end
    get 'products/:id' do
      product = Product.find_by(id: params[:id])
      error!('Product not found', 404) unless product
      product
    end

    #  POST 
    desc 'Creates a new product'
    params do
      requires :name, type: String, desc: 'Product Name'
      requires :price, type: Integer, desc: 'Product Price'
    end
    post :products do
      product = Product.create(name: params[:name], price: params[:price])
      if product.persisted?
        product
      else
        error!(product.errors.full_messages, 400)
      end
    end

    #  PUT 
    desc 'Updates a product'
    params do
      requires :id, type: Integer, desc: 'Product ID'
      requires :name, type: String, desc: 'Product Name'
      requires :price, type: Integer, desc: 'Product Price'
    end
    put 'products/:id' do
      product = Product.find_by(id: params[:id])
      error!('Product not found', 404) unless product

      if product.update(name: params[:name], price: params[:price])
        product
      else
        error!(product.errors.full_messages, 400)
      end
    end

    #  PATCH 
    desc 'Partially updates a product'
    params do
      requires :id, type: Integer, desc: 'Product ID'
      optional :name, type: String, desc: 'Product Name'
      optional :price, type: Integer, desc: 'Product Price'
    end
    patch 'products/:id' do
      product = Product.find_by(id: params[:id])
      error!('Product not found', 404) unless product

      if product.update(declared(params, include_missing: false))
        product
      else
        error!(product.errors.full_messages, 400)
      end
    end

    #  DELETE 
    desc 'Deletes a product'
    params do
      requires :id, type: Integer, desc: 'Product ID'
    end
    delete 'products/:id' do
      product = Product.find_by(id: params[:id])
      error!('Product not found', 404) unless product

      product.destroy
      { message: 'Product deleted successfully' }
    end

    #  Swagger Documentation
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
      },
      security: [{ basic_auth: [] }] 
    )
  end
end
