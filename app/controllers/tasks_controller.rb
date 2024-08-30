class TasksController < ApplicationController
  def index
    @tasks = Task.where(board_id: params[:board_id])
  end

  def new
    @task = current_user.tasks.build(board_id: params[:board_id])
  end

  def create
    @task = current_user.tasks.build(task_params.merge(board_id: params[:board_id]))
    if @task.save
      flash[:notice] = "タスクの作成に成功しました"
      redirect_to board_tasks_path(board_id: params[:board_id])
    else
      flash.now[:alert] = "タスクの作成に失敗しました"
      render :new
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  private
  def task_params
    params.require(:task).permit(:name, :desc, :deadline)
  end

end