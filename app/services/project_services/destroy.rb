module ProjectServices
  class Destroy < ApplicationService
    def initialize(project:, current_user:)
      @project = project
      @current_user = current_user

      super()
    end

    def run
      check_permissions or return false
      destroy_project   or return false

      success?
    end

    private

    # Getters
    attr_reader :project, :current_user

    def check_permissions
      return true if policy.destroy?
      add_error(:base, "You don't have an access to delete this Project")
    end

    def destroy_project
      project.destroy
    end

    def policy
      return @policy if defined?(@policy)
      @policy = ProjectPolicy.new(current_user, project)
    end
  end
end
