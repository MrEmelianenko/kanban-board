class IssuesController < ApplicationController
  def show
    render locals: { issue: issue.decorate }
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
    service = IssueServices::Update.run!(
      issue: issue,
      issue_params: issue_params,
      current_user: current_user
    )

    if service.success?
      redirect_to project_path(issue.project), notice: 'Issue successfully updated'
    else
      redirect_to :edit, locals: { issue: service.issue, errors: service.errors }
    end
  end

  def destroy
    service = IssueServices::Destroy.run!(
      issue: issue,
      current_user: current_user
    )

    if service.success?
      redirect_to project_path(issue.project_id), notice: 'Issue successfully deleted'
    else
      redirect_to :back, flash: { error: service.errors[:base]&.first }
    end
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
      .permit(:assigned_to_id, :issue_type_id, :project_id, :title, :description, :priority, :estimate)
  end
end
