class IssuePolicy < ApplicationPolicy
  def create?
    ProjectUser.exists?(project_id: record.project_id, user_id: user.id)
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
