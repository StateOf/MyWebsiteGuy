require "rails_helper"

describe ProjectsController do

  before :each do

    user = create_user
    session[:user_id] = user.id
    @project = create_project
    membership = create_membership(user, @project)

  end

  describe "permissions" do
    it "automatically added as project owner upon creating that project" do

      get :new

      expect {
        post :create, project: { name: "Play Banjo" }
      }.to change {Project.all.count}.by(1)

      expect(Membership.last.role).to eq "Owner"

    end

    it "redirects users to the Task index page upon creating a new project" do

      get :new

      expect {
        post :create, project: { name: "Test Project" }
      }.to change {Project.all.count}.by(1)

      expect(response).to redirect_to project_tasks_path(Project.last)

    end

    it "redirects to projects path if trying to access show" do

      get :edit

      user = create_user

      project_id: create_project.id

      membership.id = nil

      expect(response).to redirect_to projects_path

    end

  end

  describe "GET #index" do
    it "lists all projects on gCamp" do

      get :index

      expect(assigns(:projects)).to eq Project.all
    end

    it "renders the :index template" do

      get :index

      expect(response).to render_template :index
    end

  end


  describe "GET #show" do
    it "assigns the requested project to @project" do

      get :show, id: @project
      expect(assigns(:project)).to eq @project

    end

    it "renders the :show template" do

      get :show, id: @project
      expect(response).to render_template :show
    end
  end

end
