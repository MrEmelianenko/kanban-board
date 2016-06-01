module IssueServices
  class Update < ApplicationService
    # Getters
    attr_reader :issue

    def initialize(issue:, issue_params:, current_user:)
      @issue = issue
      @issue_params = issue_params
      @current_user = current_user

      super()
    end

    def run
      check_permissions or return false
      validate_data     or return false
      update_issue      or return false

      success?
    end

    private

    # Getters
    attr_reader :issue_params, :current_user

    # Setters
    attr_writer :issue

    def check_permissions
      return true if policy.update?
      add_error(:base, "You don't have an access to update this Issue")
    end

    def validate_data
      issue.assign_attributes(issue_params)
      merge_model_errors(issue) unless issue.valid?

      success?
    end

    def update_issue
      issue.save
    end

    def policy
      return @policy if defined?(@policy)
      @policy = IssuePolicy.new(current_user, issue)
    end
  end
end
