class Issue < ApplicationRecord
  # Associations
  belongs_to :project
  belongs_to :creator, class_name: 'User'
  belongs_to :assigned_to, class_name: 'User'
  belongs_to :issue_type
  has_many :comments, dependent: :destroy
end
