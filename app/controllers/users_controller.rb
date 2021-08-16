class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :following, :followers]
  before_action :correct_user, only: [:edit, :update]


  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = t'flash.users.signup'
      redirect_to request.referrer || root_url
    else
      render 'new'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = t'flash.users.delete'
    redirect_to users_url
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    @micropost = @user.microposts.build
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = t'flash.users.update'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def following
    @title = t'account.following'
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = t'account.followers'
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation,
                                :user_avatar,
                                :gender)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t'flash.log_in'
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
