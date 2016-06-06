class Api::V1::UsersController < ApiController
  swagger_controller :users, 'User Management'

  swagger_api :index do |api|
    summary 'Get all users'
    ApiController.add_common_response(api)
  end

  def index
    @users = User.all
  end

end