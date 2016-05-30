class UsersController < ApplicationController
  def index
    render locals: { users: users }
  end

  def show
    render locals: { user: user }
  end

  def edit
    render locals: { user: user, errors: {} }
  end

  def update
    service = UserServices::Update.run!(params, current_user: current_user)

    if service.success?
      redirect_to user_url(service.user)
    else
      render :edit, locals: { user: service.user, errors: service.errors }
    end
  end

  private

  def users
    return @users if defined?(@users)
    @users = User.all

    authorize User
    @users
  end

  def user
    return @user if defined?(@user)
    @user = User.find(params[:id])

    authorize @user
    @user
  end
end
