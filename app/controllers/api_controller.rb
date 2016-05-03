class ApiController < ApplicationController
  layout false
  skip_before_action :verify_authenticity_token

  rescue_from ActiveRecord::RecordNotFound, with: :exception_not_found

  def exception_not_found
    render json: { errors: ['Not found']}, status: :unprocessable_entity
  end


end