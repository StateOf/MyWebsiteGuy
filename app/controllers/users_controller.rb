class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end

end
