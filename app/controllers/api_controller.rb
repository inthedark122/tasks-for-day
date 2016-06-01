class ApiController < ApplicationController
  layout false
  skip_before_action :verify_authenticity_token
  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers


  rescue_from ActiveRecord::RecordNotFound, with: :exception_not_found
  rescue_from CanCan::AccessDenied, with: :exception_need_auth

  def exception_not_found exception
    render json: {errors: [{message: [exception.message]}]}, status: :unprocessable_entity
  end

  def exception_need_auth
    render json: {errors: [{message: ['Need auth']}]}, status: :unprocessable_entity
  end

  def self.add_common_response(api)
    api.response :ok
    api.response :unprocessable_entity
  end

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  def cors_preflight_check
    if request.method == 'OPTIONS'
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token'
      headers['Access-Control-Max-Age'] = '1728000'

      render :text => '', :content_type => 'text/plain'
    end
  end

end