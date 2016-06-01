class Issue < ApplicationRecord
  # Includes
  include AASM

  # Associations
  belongs_to :project
  belongs_to :creator, class_name: 'User'
  belongs_to :assigned_to, class_name: 'User', optional: true
  belongs_to :issue_type
  has_many :comments, dependent: :destroy

  # Validation
  validates :title, presence: true
  validates :estimate, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 600 }, allow_nil: true

  # Scopes
  default_scope -> { order(:position) }

  # Enumerable
  enum priority: {
    low:    0,
    medium: 1,
    high:   2
  }

  enum state: {
    backlog:     0,
    in_progress: 1,
    in_review:   2,
    done:        3
  }

  # State machine
  aasm :state, enum: true do
    state :backlog, initial: true
    state :in_progress
    state :in_review
    state :done

    event :to_backlog, before_transaction: :clear_dates do
      transitions from: :in_progress, to: :backlog
    end

    event :to_in_progress, before_transaction: :set_started_at do
      transitions from: [:backlog, :in_review], to: :in_progress
    end

    event :to_in_review, before_transaction: :set_completed_at do
      transitions from: [:in_progress, :done], to: :in_review
    end

    event :to_done do
      transitions from: :in_review, to: :done
    end
  end

  private

  def clear_dates
    self.started_at = nil
    self.completed_at = nil
  end

  def set_started_at
    self.started_at ||= Time.now
    self.completed_at = nil
  end

  def set_completed_at
    self.completed_at ||= Time.now
  end
end
