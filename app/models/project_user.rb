class ProjectUser < ApplicationRecord
  # Associations
  belongs_to :project
  belongs_to :user

  # Validates
  validates :project_id, uniqueness: { scope: :user_id }
  validates :access_level, presence: true

  # Enumerable
  enum access_level: {
    default: 0,
    admin:   1
  }
end
