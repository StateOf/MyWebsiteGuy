require "rails_helper"

describe MembershipsController do

  before :each do
    @user = create_user
    session[:user_id] = @user.id
    @project = create_project
    @membership = create_membership(@user, @project)
  end

  describe "permissions" do

    it "redirects to signin path if not logged in" do
      session.clear

      get :index, project_id: @project.id
      expect(response).to redirect_to signin_path
    end

    it "redirects non-members or admin from membership index to projects path" do

      session.clear
      @user1 = create_user(first_name: "Dylan", email: "user1@gmail.com", password: "password", admin: false)
      session[:user_id] = @user1.id

      get :index, project_id: @project.id
      expect(flash[:error]).to eq "You do not have access to that project"
      expect(response).to redirect_to projects_path
    end

    it "redirects non-owner or admin from membership index to projects path" do

      session.clear
      @user1 = create_user(first_name: "Dylan", email: "user1@gmail.com", password: "password", admin: false)
      session[:user_id] = @user1.id

      post :create, project_id: @project.id
      expect(flash[:error]).to eq "You do not have access to that project"
      expect(response).to redirect_to projects_path

    end

    it "redirects non-owner or admin from membership index to projects path" do

      session.clear
      @user1 = create_user(first_name: "Dylan", email: "user1@gmail.com", password: "password", admin: false)
      session[:user_id] = @user1.id

      patch :update, project_id: @project.id, id: @membership.id
      expect(flash[:error]).to eq "You do not have access to that project"
      expect(response).to redirect_to projects_path

    end

    it "owner only can update project's membership" do

      user1 = create_user(first_name: "Dylan", email: "user1@gmail.com", password: "password", admin: false)
      membership2 = create_membership(user1, @project, role: "Owner")

      expect {
        patch :update, project_id: @project.id, id: membership2.id, membership: {role: "Member"}

      }.to change {membership2.reload.role}.from("Owner").to("Member")

      expect(flash[:message]).to eq "#{membership2.user.full_name} was successfully updated"
      expect(response).to redirect_to project_memberships_path

    end

    it "owner only can delete project's membership" do
      user1 = create_user(first_name: "Dylan", email: "user1@gmail.com", password: "password", admin: false)
      membership2 = create_membership(user1, @project, role: "Owner")

      expect {
        delete :destroy, project_id: @project.id, id: membership2.id, membership: {role: "Owner"}

      }.to change(Membership,:count).by(-1)

      expect(flash[:message]).to eq "#{membership2.user.full_name} was successfully removed"
      expect(response).to redirect_to project_memberships_path

    end

    it "can delete project's membership for self and redirects to projects path" do
      session.clear
      user2 = create_user(first_name: "Gilbert", email: "user2@gmail.com", password: "password", admin: false)
      user1 = create_user(first_name: "Dylan", email: "user1@gmail.com", password: "password", admin: false)
      session[:user_id] = user1.id
      membership2 = create_membership(user1, @project, role: "Member")
      membership3 = create_membership(user2, @project, role: "Owner")

      expect {
        delete :destroy, project_id: @project.id, id: membership2.id
      }.to change{ Membership.all.count }.by(-1)

      expect(flash[:message]).to eq "#{membership2.user.full_name} was successfully removed"
      expect(response).to redirect_to projects_path
    end

    it "admin, owner, or the own user can delete a project's membership" do

      user1 = create_user(first_name: "Dylan", email: "user1@gmail.com", password: "password", admin: false)
      user2 = create_user(first_name: "Gilbert", email: "test@gmail.com", password: "dog", admin: false)
      project2 = create_project(name: "Testing Project")
      membership1 = create_membership(user1, project2, role: "Member")
      membership2 = create_membership(user2, project2, role: "Member")
      session[:user_id] = user1.id

      expect {
        delete :destroy, project_id: project2.id, id: membership2.id, membership: {role: "Member"}
      }.to_not change{ Membership.all.count }

      expect(flash[:error]).to eq "You do not have access"
      expect(response).to redirect_to projects_path
    end

    it "has at least one owner for a project's membership" do

      user1 = create_user(first_name: "Jennifer", last_name: "Greatest", email: "user1@gmail.com", password: "password", admin: true)
      user2 = create_user(first_name: "Steve", last_name: "Lonely", email: "lonelysteve@gmail.com", password: "sad", admin: false )
      project2 = create_project(name: "Find Steve a life")
      membership1 = create_membership(user1, project2, role: "Member")
      membership2 = create_membership(user2, project2, role: "Owner")
      session[:user_id] = user1.id

      expect {
        delete :destroy, project_id: project2.id, id: membership2.id, membership: {role: "Owner"}
      }.to_not change{Membership.all.count}

      expect(flash[:error]).to eq "Projects must have at least one owner"
      expect(response).to redirect_to project_memberships_path
    end

    it "has at least one owner for a project's membership" do

      user1 = create_user(first_name: "Jennifer", last_name: "Greatest", email: "user1@gmail.com", password: "password", admin: true)
      user2 = create_user(first_name: "Steve", last_name: "Lonely", email: "lonelysteve@gmail.com", password: "sad", admin: false )
      project2 = create_project(name: "Find Steve a life")
      membership1 = create_membership(user1, project2, role: "Member")
      membership2 = create_membership(user2, project2, role: "Owner")
      session[:user_id] = user1.id

      expect {
        patch :update, project_id: project2.id, id: membership2.id, membership: {role: "Member"}
      }.to_not change{membership2.reload.role}

      expect(flash[:error]).to eq "Projects must have at least one owner"
      expect(response).to redirect_to project_memberships_path
    end

  end

end
