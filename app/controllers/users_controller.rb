class UsersController < PrivateController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :current_user_404, only: [:edit, :udpate]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:message] = "User was successfully created"
      redirect_to users_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:message] = "User was successfully updated"
      redirect_to users_path
    else
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:message] = "User was successfully deleted"
    redirect_to users_path
  end

  private

  def user_params
    if current_user.admin
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :admin)
    else
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
  end

  def set_user
    @user = User.find(params[:id])
  end


end
