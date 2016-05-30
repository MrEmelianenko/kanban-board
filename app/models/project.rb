class Project < ApplicationRecord
  # Associations
  belongs_to :creator, class_name: 'User'
  has_many :project_users, dependent: :destroy
  has_many :users, through: :project_users
  has_many :issues, dependent: :destroy
end
