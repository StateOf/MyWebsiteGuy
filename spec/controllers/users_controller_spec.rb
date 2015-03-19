require 'rails_helper'

describe UsersController do
  describe "POST #create" do
    it "creates a new user when valid parameters are passed" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end
end
