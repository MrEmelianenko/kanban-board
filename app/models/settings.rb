class Settings < ApplicationRecord
  # Settings
  self.primary_key = :key

  # Validation
  validates :key, presence: true, format: { with: /\A[a-z_]+\z/ }, uniqueness: true
  validates :value, presence: true
end
