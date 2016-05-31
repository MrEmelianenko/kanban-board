module UserServices
  class Update < ApplicationService
    # Getters
    attr_reader :user

    def initialize(user:, user_params:, current_user:, current_password:)
      @user = user
      @user_params = user_params
      @current_user = current_user
      @current_password = current_password

      @policy = UserPolicy.new(current_user, user)

      super()
    end

    def run
      check_permissions or return false
      validate_data     or return false
      update_user
    end

    private

    # Getters
    attr_reader :user_params, :current_user, :current_password, :policy

    def check_permissions
      unless policy.update?
        add_error(:base, "You don't have access to editing this user")
        return false
      end

      if policy.update_pass_required? && !user.authenticate(current_password)
        add_error(:current_password, 'is wrong')
        return false
      end

      success?
    end

    def validate_data
      user.assign_attributes(user_params)
      merge_model_errors(user) unless user.valid?

      success?
    end

    def update_user
      user.save
    end
  end
end
