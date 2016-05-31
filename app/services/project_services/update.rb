module ProjectServices
  class Update < ApplicationService
    # Getters
    attr_reader :project

    def initialize(project:, project_params:, current_user:)
      @project = project
      @project_params = project_params
      @current_user = current_user

      super()
    end

    def run
      check_permissions or return false
      validate_data     or return false
      update_project    or return false

      success?
    end

    private

    # Getters
    attr_reader :project_params, :current_user

    # Setters
    attr_writer :project

    def check_permissions
      return true if policy.update?
      add_error(:base, "You don't have an access to update this Project")
    end

    def validate_data
      project.assign_attributes(project_params)
      merge_model_errors(project) unless project.valid?

      success?
    end

    def update_project
      project.save
    end

    def policy
      return @policy if defined?(@policy)
      @policy = ProjectPolicy.new(current_user, project)
    end
  end
end
