require "rails_helper"

describe TasksController do

  before :each do
    @user = create_user
    session[:user_id] = @user.id
    @project = create_project
    @membership = create_membership(@user, @project)
  end

  describe "permissions" do

    it "requires only members to create tasks" do

      session.clear
      user1 = create_user(first_name: "Dylan", email: "user1@gmail.com", password: "password", admin: false)
      session[:user_id] = user1.id

      get :index, project_id: @project.id
      expect(flash[:error]).to eq "You do not have access to that project"
      expect(response).to redirect_to projects_path
    end
  end

end
