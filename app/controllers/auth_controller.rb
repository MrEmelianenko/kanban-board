class AuthController < ApplicationController
  # Settings
  layout 'authentication'

  # Callbacks
  skip_before_action :authentication_required!, except: [:sign_out]
  before_action :non_authentication_required!, except: [:sign_out]

  def sign_in
    render
  end

  def sign_up
    render locals: { user: User.new }
  end

  def sign_out
    user_sign_out
    redirect_to sign_in_url
  end

  def login
    service = UserServices::SignIn.run!(params)

    if service.success?
      user_sign_in(service.user)
      redirect_to root_path
    else
      render :sign_in, locals: { errors: service.errors }
    end
  end

  def register
    service = UserServices::SignUp.run!(params)

    if service.success?
      if service.user.blocked?
        redirect_to sign_in_path, flash: { notice: 'Account successfully created. Please wait for activation' }
      else
        user_sign_in(service.user)
        redirect_to root_path
      end
    else
      render :sign_up, locals: { user: service.user, errors: service.errors }
    end
  end
end
