module UserServices
  class Omniauth < ApplicationService
    # Getters
    attr_reader :user

    def initialize(params, omniauth, current_user: nil)
      @params = params
      @omniauth = omniauth
      @current_user = current_user
      @user = nil

      super()
    end

    def run
      detect_user or link_user or create_user
      success?
    end

    private

    # Getters
    attr_reader :params, :omniauth, :current_user

    # Setters
    attr_writer :user, :current_user

    def detect_user
      self.user = UserAccount.find_by(account_params)&.user
    end

    def link_user
      unless current_user
        self.current_user = User.find_by(email: omniauth.dig(:info, :email))
        return false if current_user.blank?
      end

      self.user = current_user
      user.user_accounts.create!(account_params.merge(data: omniauth.to_hash))
    end

    def create_user
      service = UserServices::SignUp.run!(user: user_params)

      if service.success?
        self.user = service.user
        user.user_accounts.create!(account_params.merge(data: omniauth.to_hash))
      else
        errors.reverse_merge!(service.errors)
      end

      success?
    end

    def user_params
      {
        name:                   params.dig(:user, :name)  || omniauth.dig(:info, :name),
        email:                  params.dig(:user, :email) || omniauth.dig(:info, :email),
        avatar_url:             omniauth.dig(:extra, :raw_info, :picture),
        password:               params.dig(:user, :password),
        password_confirmation:  params.dig(:user, :password_confirmation)
      }
    end

    def account_params
      { provider: omniauth[:provider], uid: omniauth[:uid] }
    end
  end
end
