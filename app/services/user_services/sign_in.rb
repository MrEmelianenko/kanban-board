module UserServices
  class SignIn < ApplicationService
    # Getters
    attr_reader :user

    def initialize(params)
      @email = params[:email]
      @password = params[:password]
      @user = nil

      super() # Initialize helpful variables
    end

    def run
      validate_data  or return false
      check_password or return false
      check_state    or return false

      success?
    end

    private

    # Getters
    attr_reader :email, :password

    # Setters
    attr_writer :user

    def validate_data
      add_error(:email, "can't be blank") if email.blank?
      add_error(:password, "can't be blank") if password.blank?

      success?
    end

    def check_password
      self.user = User.find_by(email: email)
      add_error(:base, 'Email or password is wrong') if user.blank? || !user.authenticate(password)

      success?
    end

    def check_state
      add_error(:base, 'Your account not activated yet') if user.blocked?

      success?
    end
  end
end
