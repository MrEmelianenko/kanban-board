class IssuesController < ApplicationController
  def show
    render locals: { issue: issue }
  end

  def new
    render locals: { issue: project.issues.new }
  end

  def create
    service = IssueServices::Create.run!(
      issue_params: issue_params,
      current_user: current_user
    )

    if service.success?
      redirect_to project_issue_path(project, service.issue), notice: 'Issue successfully created'
    else
      render :new, locals: { issue: service.issue, errors: service.errors }
    end
  end

  def edit
    render locals: { issue: issue }
  end

  def update
  end

  def destroy
  end

  private

  def project
    return @project if defined?(@project)
    @project = Project.find(params[:project_id])

    authorize @project
    @project
  end

  def issues
    return @issues if defined?(@issues)
    @issues = policy_scope(project.issues)
  end

  def issue
    return @issue if defined?(@issue)
    @issue = project.issues.find(params[:id])

    authorize @issue
    @issue
  end

  def issue_params
    params.require(:issue)
      .permit(:assigned_to_id, :issue_type_id, :title, :description, :priority, :estimate)
      .merge(project_id: project.id)
  end
end
