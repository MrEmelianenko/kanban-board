class User < ApplicationRecord
  # Settings
  has_secure_password
  has_secure_token :authentication_token

  # Associations
  has_many :issues,           foreign_key: :creator_id,                          dependent: :destroy
  has_many :assigned_issues,  foreign_key: :assigned_to_id, class_name: 'Issue', dependent: :nullify
  has_many :comments,         foreign_key: :creator_id,                          dependent: :destroy
  has_many :created_projects, foreign_key: :creator_id, class_name: 'Project',   dependent: :destroy
  has_many :project_users, dependent: :destroy
  has_many :projects, through: :project_users
  has_many :user_accounts, dependent: :destroy

  # Validation
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  # Enumerable
  enum state: {
    blocked: 0,
    active:  1,
    admin:   2
  }
end
