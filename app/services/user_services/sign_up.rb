module UserServices
  class SignUp < ApplicationService
    # Getters
    attr_reader :user

    def initialize(params)
      @params = params
      @user = nil

      super()
    end

    def run
      validate_data or return false
      create_user
    end

    private

    # Getters
    attr_reader :params

    # Setters
    attr_writer :user

    def validate_data
      self.user = User.new(user_params)
      merge_model_errors(user) unless user.valid?

      success?
    end

    def create_user
      user.state = define_user_state
      user.save
    end

    def define_user_state
      admin_emails = Settings.find_by(key: 'admin_emails')&.value.to_s

      if admin_emails.split(' ').include?(user.email.downcase)
        User.states[:admin]
      else
        User.states[:blocked]
      end
    end

    def user_params
      if params.is_a?(ActionController::Parameters)
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      else
        params[:user]
      end
    end
  end
end
