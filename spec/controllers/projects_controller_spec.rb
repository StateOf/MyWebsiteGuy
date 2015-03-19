require "rails_helper"

describe ProjectsController do
  describe "GET #index" do
    it "lists all projects on gCamp" do

      get :index

      expect(assigns(:projects)).to eq [Project.all]
    end
  end
end
