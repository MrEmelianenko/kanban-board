class UsersController < ApplicationController
  def index
    render locals: { users: users }
  end

  def show
    render locals: { user: user }
  end

  def edit
    render locals: { user: user }
  end

  def update
    service = UserServices::Update.run!(
      user: user,
      user_params: user_params,
      current_user: current_user,
      current_password: params.dig(:user, :current_password)
    )

    if service.success?
      redirect_to user_url(service.user)
    else
      render :edit, locals: { user: service.user, errors: service.errors }
    end
  end

  private

  def users
    return @users if defined?(@users)

    authorize User
    @users = User.all
  end

  def user
    return @user if defined?(@user)
    @user = User.find(params[:id])

    authorize @user
    @user
  end

  def user_params
    if policy(user).update_system_information?
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :state)
    else
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  end
end
