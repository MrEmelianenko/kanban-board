class Comment < ApplicationRecord
  # Associations
  belongs_to :issue
  belongs_to :creator, class_name: 'User'

  # Validation
  validates :text, presence: true
end
