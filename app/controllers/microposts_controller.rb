class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :report, :update]
  before_action :correct_user, only: :destroy
  def create
    @micropost = current_user.microposts.build(microposts_params)
    if @micropost.save
      flash[:success] = t'flash.microposts.created'
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = t'flash.microposts.delete'
    redirect_to request.referrer || root_url
  end

  def report
    # pry()
    @micropost = Micropost.find_by(id: params[:micropost_id])
    @reported_comment = @micropost.reported_comments.build
  end

  private

  def microposts_params
    params.require(:micropost).permit(:content, :picture, :blocked, :reported)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end 