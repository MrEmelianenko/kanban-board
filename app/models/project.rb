class Project < ApplicationRecord
  # Associations
  belongs_to :creator, class_name: 'User'
  has_many :project_users, dependent: :destroy
  has_many :users, through: :project_users
  has_many :issues, dependent: :destroy

  # Validation
  validates :name, presence: true

  # Nested attributes
  accepts_nested_attributes_for :project_users, reject_if: :all_blank, allow_destroy: true
end
