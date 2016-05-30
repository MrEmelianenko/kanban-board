module Authenticatable
  extend ActiveSupport::Concern

  included do
    def current_user
      return RequestStore.store[:current_user] if RequestStore.exist?(:current_user)

      if session[:authentication_token].present?
        RequestStore.store[:current_user] = User.find_by(authentication_token: session[:authentication_token])
      else
        RequestStore.store[:current_user] = nil
      end
    end

    def user_signed_in?
      current_user.present?
    end

    def user_sign_in(user)
      session[:authentication_token] = user.authentication_token
    end

    def user_sign_out
      session.delete(:authentication_token)
    end

    def authentication_required!
      user_signed_in? or raise Exceptions::Authentication::Required
    end

    def non_authentication_required!
      !user_signed_in? or raise Exception::Authentication::OnlyForGuests
    end

    helper_method :current_user, :user_signed_in?
  end
end
