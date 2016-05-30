class IssueType < ApplicationRecord
  # Associations
  has_many :issues, dependent: :nullify
end
