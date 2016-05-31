module ProjectServices
  class Create < ApplicationService
    # Getters
    attr_reader :project

    def initialize(project_params:, current_user:)
      @project_params = project_params
      @current_user = current_user

      @project = nil

      super()
    end

    def run
      validate_data     or return false
      check_permissions or return false
      create_project    or return false
      add_creator_to_members

      success?
    end

    private

    # Getters
    attr_reader :project_params, :current_user

    # Setters
    attr_writer :project

    def validate_data
      self.project = Project.new(project_params.merge(creator: current_user))
      merge_model_errors(project) unless project.valid?

      success?
    end

    def check_permissions
      return true if policy.create?
      add_error(:base, "You don't have an access to create this Project")
    end

    def create_project
      project.save
    end

    def add_creator_to_members
      project.project_users.create!(user: current_user, access_level: ProjectUser.access_levels[:admin])
    end

    def policy
      return @policy if defined?(@policy)
      @policy = ProjectPolicy.new(current_user, project)
    end
  end
end
