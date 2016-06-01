module IssueServices
  class ChangeState < ApplicationService
    # Getters
    attr_reader :issue

    def initialize(issue:, state:, current_user:)
      @issue = issue
      @state = state.to_s
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
    attr_reader :state, :current_user

    # Setters
    attr_writer :issue

    def check_permissions
      return true if policy.update?
      add_error(:base, "You don't have an access to update this Issue")
    end

    def validate_data
      unless Issue.states.keys.include?(state)
        add_error(:base, 'is wrong')
        return false
      end

      unless issue.public_send("may_to_#{state}?")
        add_error(:base, "You can not change the state to \"#{state.humanize.capitalize}\"")
        return false
      end

      success?
    end

    def update_issue
      issue.public_send("to_#{state}!")
    end

    def policy
      return @policy if defined?(@policy)
      @policy = IssuePolicy.new(current_user, issue)
    end
  end
end
