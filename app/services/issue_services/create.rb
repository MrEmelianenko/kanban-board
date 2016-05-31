module IssueServices
  class Create < ApplicationService
    # Getters
    attr_reader :issue

    def initialize(issue_params:, current_user:)
      @issue_params = issue_params
      @current_user = current_user

      @issue = nil

      super()
    end

    def run
      validate_data     or return false
      check_permissions or return false
      create_issue      or return false

      success?
    end

    private

    # Getters
    attr_reader :issue_params, :current_user

    # Setters
    attr_writer :issue

    def validate_data
      self.issue = Issue.new(attributes)
      merge_model_errors(issue) unless issue.valid?

      success?
    end

    def check_permissions
      return true if policy.create?
      add_error(:base, "You don't have an access to create this Issue")
    end

    def create_issue
      issue.save
    end

    def attributes
      issue_params.merge(
        creator: current_user,
        position: Issue.maximum(:position).to_i + 1
      )
    end

    def policy
      return @policy if defined?(@policy)
      @policy = IssuePolicy.new(current_user, issue)
    end
  end
end
