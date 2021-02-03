class CommentsController < ApplicationController

  def create
    comment = Comment.create(comment_params)
    @work = Work.find(params[:work_id])
    redirect_to  work_path(@work)
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, work_id: params[:work_id])
  end

end
