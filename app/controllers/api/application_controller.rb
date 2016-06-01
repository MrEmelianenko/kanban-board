class API::ApplicationController < ActionController::Base
  # Includes
  include Pundit
  include LoadSettings
  include Authenticatable

  # Callbacks
  before_action :authentication_required!

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  protected

  def response_service(service)
    if service.success?
      render json: { status: :ok }
    else
      render json: { status: :error, message: service.errors[:base]&.first }, status: :bad_request
    end
  end
end
