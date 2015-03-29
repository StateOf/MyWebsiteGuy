require 'rails_helper'


describe AboutController do

  describe 'GET #index' do

    it "counts all of the projects, tasks, comments, memberships, and users" do
      projects = create_project
      users = create_user
      tasks = create_task(projects)
      comments = create_comment(users, tasks)
      memberships = create_membership(users, projects)
      get :index
      expect(assigns(:projects)).to eq [projects]
      expect(assigns(:tasks)).to eq [tasks]
      expect(assigns(:comments)).to eq [comments]
      expect(assigns(:memberships)).to eq [memberships]
      expect(assigns(:users)).to eq [users]
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "skips before action an ensured current user" do
      get :index
      expect(response).to render_template("index")
    end

  end
  
end
