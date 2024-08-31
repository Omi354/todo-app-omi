class CommentsController < ApplicationController
  def new
    @comment = current_user.comments.build
  end

  def create
    @comment = current_user.comments.build(comment_params.merge(task_id: params[:task_id]))
    if @comment.save
      flash[:notice] = "コメントの作成に成功しました"
      redirect_to board_task_path(board_id: params[:board_id], id: params[:task_id])
    else
      flash.now[:alert] = "コメントの作成に失敗しました"
      render :new
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end

end