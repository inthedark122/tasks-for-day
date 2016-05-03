class Api::V1::Users::SessionsController < Devise::SessionsController
  def new
    redirect_to unauthenticated_root_path if !request.xhr?
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