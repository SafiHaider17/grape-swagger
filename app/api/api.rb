module Api
  class Base < Grape::API
    format :json

    #  Basic Authentication Middleware
    http_basic do |username, password|
      username == 'admin' && password == 'password123' # Change this for security
    end

    # before do
    #   header 'Access-Control-Allow-Origin', '*'
    #   header 'Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS'
    #   header 'Access-Control-Allow-Headers', 'Origin, Content-Type, Accept, Authorization'
    # end

    # ✅ Simple "Hello World" endpoint
    desc 'Returns Hello World message'
    get :hello do
      { message: 'Hello World from Grape API' }
    end

    # ✅ Returns the current time
    desc 'Returns the current time'
    get :time do
      { time: Time.now }
    end

    # ✅ Products Endpoint
    desc 'Returns a list of products'
    get :products do
      [
        { name: 'Laptop', price: 75000 },
        { name: 'Mobile Phone', price: 25000 },
        { name: 'Headphones', price: 5000 }
      ]
    end

    # ✅ Swagger documentation
    add_swagger_documentation(
      info: {
        title: 'My Grape API',
        description: 'This is a simple API with authentication and product listing'
      },
      base_path: '/',
      security_definitions: {
        basic_auth: {
          type: 'basic' #  Basic Authentication added
        }
      }
    )
  end
end
