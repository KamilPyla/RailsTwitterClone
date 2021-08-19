class ReportedCommentsController < ApplicationController

  def create
    @micropost = Micropost.find_by(id: params[:reported_comment][:micropost_id])
    @reported_comment = @micropost.reported_comments.create(reported_comment_params)
    @reported_comment.user = current_user
    if @reported_comment.save
      flash[:success] = 'Post was reported successfully'
      @micropost.update(reported: true)
      redirect_to root_path
    end
  end

  private

  def reported_comment_params
    params.require(:reported_comment).permit(:content, :micropost_id, :user_id, :user)
  end
end
