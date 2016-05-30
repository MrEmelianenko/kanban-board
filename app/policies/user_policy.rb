class UserPolicy < ApplicationPolicy
  def index?
    true
  end

  def update?
    user == record || user.admin?
  end

  def update_system_information?
    user.admin? && user != record
  end

  def update_pass_required?
    !user.admin? || user == record
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
