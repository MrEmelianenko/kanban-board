class API::IssuesController < API::ApplicationController
  def update
    service = IssueServices::Update.run!(
      issue: issue,
      issue_params: issue_params,
      current_user: current_user
    )

    response_service(service)
  end

  def change_state
    service = IssueServices::ChangeState.run!(
      issue: issue,
      state: params[:state],
      current_user: current_user
    )

    response_service(service)
  end

  private

  def issue
    return @issue if defined?(@issue)
    @issue = Issue.find(params[:id])

    authorize @issue
    @issue
  end

  def issue_params
    params.require(:issue).permit(:position)
  end
end
