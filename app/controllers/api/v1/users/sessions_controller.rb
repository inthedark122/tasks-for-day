class Api::V1::Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token

  swagger_controller :users, 'User Management'

  swagger_api :create do
    summary 'Sign in'
    param :form, 'user[email]', :string, :required, 'Email address'
    param :form, 'user[password]', :string, :required, 'Password'
    response :ok
    response :unauthorized
  end
  def create
    user = User.find_by(email: sign_in_params[:email])
    if user && user.valid_password?(sign_in_params[:password])
      set_flash_message :notice, :signed_up if is_flashing_format?
      sign_in(resource_name, user)
      @success_path = after_sign_in_path_for(user)
      render json: { path: @success_path }
    else
      render json: { errors: t('devise.failure.invalid') }, status: 401
    end
  end

  swagger_api :destroy do |api|
    summary 'Log out'
    response :ok
    response :unauthorized
  end
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message :notice, :signed_out if signed_out && is_flashing_format?
    # yield if block_given?
    # respond_to_on_destroy
    render json: { path: '/' }
  end

  private

  def sign_in_params
    params.require(:user).permit(:email, :password)
  end
end