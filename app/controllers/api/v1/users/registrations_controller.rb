class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token

  swagger_controller :users, 'User Management'

  swagger_api :create do |api|
    summary 'Creates a new User'
    Api::V1::Users::RegistrationsController::add_common_params(api)
    response :created
    response :unprocessable_entity
  end
  def create
    build_resource(sign_up_params)

    if resource.save
      set_flash_message :notice, :signed_up if is_flashing_format?
      sign_up(resource_name, resource)
      @success_path = after_sign_in_path_for(resource)
      render json: resource, status: :created
    else
      @errors = resource.errors
      warden.custom_failure!

      render json: { errors: @errors }, status: :unprocessable_entity
    end
  end

  swagger_api :update do |api|
    summary 'Update User'
    Api::V1::Users::RegistrationsController::add_common_params(api)
    response :ok
    response :unprocessable_entity
  end
  def update
    resource_updated = resource.update(sign_up_params)

    if resource_updated
      sign_in resource_name, resource, bypass: true
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  protected

  def self.add_common_params(api)
    api.param :form, 'user[email]', :string, :required, 'Email address'
    api.param :form, 'user[password]', :string, :required, 'Password'
  end

  private

  def sign_up_params
    params.require(:user).permit(:email,
                                 :password,
                                 :password_confirmation)
  end
end