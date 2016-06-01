class ProjectsController < ApplicationController
  def index
    render locals: { projects: projects.decorate }
  end

  def show
    render locals: {
      project: project.decorate,
      issues: project.issues.includes(:issue_type, :creator, :assigned_to)
    }
  end

  def new
    render locals: { project: Project.new }
  end

  def create
    service = ProjectServices::Create.run!(
      project_params: project_params,
      current_user: current_user
    )

    if service.success?
      redirect_to project_path(service.project), notice: 'Project successfully created'
    else
      render :new, locals: { project: service.project, errors: service.errors }
    end
  end

  def edit
    render locals: { project: project.decorate }
  end

  def update
    service = ProjectServices::Update.run!(
      project: project,
      project_params: project_params,
      current_user: current_user
    )

    if service.success?
      redirect_to project_path(service.project), notice: 'Project successfully updated'
    else
      render :edit, locals: { project: service.project, errors: service.errors }
    end
  end

  def destroy
    service = ProjectServices::Destroy.run!(
      project: project,
      current_user: current_user
    )

    if service.success?
      redirect_to projects_path, notice: 'Project successfully deleted'
    else
      redirect_to :back, flash: { error: service.errors[:base]&.first }
    end
  end

  private

  def projects
    return @projects if defined?(@projects)

    authorize Project
    @projects = policy_scope(Project)
  end

  def project
    return @project if defined?(@project)
    @project = Project.find(params[:id])

    authorize @project
    @project
  end

  def project_params
    params.require(:project).permit(
      :name, :description, project_users_attributes: [:id, :project_id, :user_id, :access_level, :_destroy]
    )
  end
end
