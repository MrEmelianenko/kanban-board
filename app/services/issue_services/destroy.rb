module IssueServices
  class Destroy < ApplicationService
    def initialize(issue:, current_user:)
      @issue = issue
      @current_user = current_user

      super()
    end

    def run
      check_permissions or return false
      destroy_issue     or return false

      success?
    end

    private

    # Getters
    attr_reader :issue, :current_user

    def check_permissions
      return true if policy.destroy?
      add_error(:base, "You don't have an access to delete this Issue")
    end

    def destroy_issue
      issue.destroy
    end

    def policy
      return @policy if defined?(@policy)
      @policy = IssuePolicy.new(current_user, issue)
    end
  end
end
