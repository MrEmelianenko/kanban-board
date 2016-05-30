class ApplicationController < ActionController::Base
  # Includes
  include Pundit
  include LoadSettings
  include Authenticatable

  # Callbacks
  before_action :authentication_required!

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from Exceptions::Authentication::Required do
    redirect_to sign_in_url
  end

  rescue_from Exceptions::Authentication::OnlyForGuests do
    redirect_to root_url
  end

  rescue_from Pundit::NotAuthorizedError do
    redirect_to root_url
  end
end
