require "rails_helper"

describe MembershipsController do

  describe "permissions" do

    it "redirects to signin path if not logged in" do

      get :index, project_id: create_project.id
      expect(response).to redirect_to signin_path

    end

  end

end
