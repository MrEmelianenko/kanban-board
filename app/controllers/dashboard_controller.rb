class DashboardController < ApplicationController
  def index
    render locals: { projects: projects.limit(10).decorate, users: users.limit(10).decorate }
  end

  private

  def projects
    return @projects if defined?(@projects)
    @projects = policy_scope(Project)
  end

  def users
    return @users if defined?(@users)
    @users = policy_scope(User)
  end
end
