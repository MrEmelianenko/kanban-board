module UserServices
  class Update < ApplicationService
    # Getters
    attr_reader :user

    def initialize(params, current_user: nil)
      @params = params
      @current_user = current_user
      @user = nil

      super() # Initialize helpful variables
    end

    def run
      load_user
      check_permissions or return false
      validate_data or return false
      create_user
    end

    private

    # Getters
    attr_reader :params, :current_user

    # Setters
    attr_writer :user

    def load_user
      self.user = User.find(params[:id])
    end

    def check_permissions
      # TODO: Use Policy in this place
      return true if current_user.admin? && user != current_user

      if user == current_user
        unless user.authenticate(params.dig(:user, :current_password))
          add_error(:current_password, 'is wrong')
        end
      else
        add_error(:base, "You don't have access to editing this user")
      end

      success?
    end

    def validate_data
      user.update(user_params)
      merge_model_errors(user) unless user.valid?

      success?
    end

    def create_user
      user.save
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :state)
    end
  end
end
