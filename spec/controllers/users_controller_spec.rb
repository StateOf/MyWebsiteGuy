require 'rails_helper'

describe UsersController do

  describe "GET #index" do
    it "lists all the users in the table" do
      user = create_user
      session[:user_id] = user.id
      get :index
      expect(assigns(:users)).to eq [(user)]
    end

    it "renders the :index template" do
      user = create_user
      session[:user_id] = user.id
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET #new" do
    it "assigns a new User to @user" do
      user = create_user
      session[:user_id] = user.id
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it "renders the :new template" do
      user = create_user
      session[:user_id] = user.id
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    it "creates a new user when valid parameters are passed" do

      user = create_user
      session[:user_id] = user.id
      get :new

      expect {
        post :create, user: { first_name: "Emily", last_name: "P", email: "emip@yahoo.com", password: "password" }
      }.to change {User.all.count}.by(1)

      user = User.last

      expect(user.first_name).to eq "Emily"
      expect(user.last_name).to eq "P"
      expect(user.email).to eq "emip@yahoo.com"
      expect(flash[:message]).to eq "User was successfully created"
      expect(response).to redirect_to users_path
    end

    it "does not create a new user if it is invalid" do

      user = create_user
      session[:user_id] = user.id
      get :new

      expect {
        post :create, user: { first_name: "Theron", last_name: nil, email: nil }
      }.to_not change { User.all.count }

      expect(response).to render_template :new
      expect(assigns(:user)).to be_a(User)
    end
  end

  describe "GET #show" do
    it "assigns the requested user to @user" do
      user = create_user
      session[:user_id] = user.id

      get :show, id: user
      expect(assigns(:user)).to eq user
    end

    it "renders the :show template" do
      user = create_user
      session[:user_id] = user.id

      get :show, id: user
      expect(response).to render_template :show
    end
  end

  describe "GET #edit" do
    it "assigns the requested use to @user to be edited" do
      user = create_user
      session[:user_id] = user.id

      get :edit, id: user
      expect(assigns(:user)).to eq user
    end

    it "renders the :edit template" do
      user = create_user
      session[:user_id] = user.id

      get :edit, id: user
      expect(response).to render_template :edit
    end
  end

  describe "PATCH #update" do
    it "locates the requested @user" do
      user = create_user
      session[:user_id] = user.id

      patch :update, id: user, user: {
        first_name: user.first_name, last_name: user.last_name, email: user.email
      }
      expect(assigns(:user)).to eq user
    end

    it "changes @user's params" do
      user = create_user
      session[:user_id] =  user.id

      patch :update, id: user, user: { first_name: "John", last_name: "Doe", email: "johndoe@gmail.com", password: "123" }
      user.reload
      expect(user.first_name).to eq("John")
      expect(user.last_name).to eq("Doe")
    end
  end

  describe "permissions" do

    it "redirects to 404 if not current user trying to edit other user" do

      @user = create_user
      user2 = create_user(first_name: "Gilbert", email: "test@gmail.com", password: "dog", admin: false)
      session[:user_id] = user2.id

      get :edit, id: @user

      expect(response).to render_template file: '404.html'
    end

  end

end
