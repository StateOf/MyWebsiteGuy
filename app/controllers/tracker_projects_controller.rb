class TrackerProjectsController < PrivateController

  def show
    tracker_api = TrackerAPI.new
    if current_user.tracker_token
      @stories = tracker_api.stories(current_user.tracker_token, params[:id])
      @project = params[:project_name]
    end
  end

end
