class ProjectPolicy < ApplicationPolicy
  def create?
    true
  end

  def update?
    user.admin? or record.creator_id == user.id or
      record.project_users.exists?(user_id: user.id, access_level: ProjectUser.access_levels[:admin])
  end

  def destroy?
    user.admin? || record.creator_id == user.id
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
