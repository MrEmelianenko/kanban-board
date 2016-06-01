class IssuePolicy < ApplicationPolicy
  def create?
    project_member?
  end

  def update?
    user.admin? || project_member?
  end

  def change_state?
    user.admin? || project_member?
  end

  def destroy?
    user.admin? || project_member?
  end

  private

  def project_member?
    ProjectUser.exists?(project_id: record.project_id, user_id: user.id)
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
