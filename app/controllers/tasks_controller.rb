class TasksController < ApplicationController
  def index
    @tasks = Task.where(board_id: params[:board_id])
    @users_with_avatars = {}
    
    @tasks.each do |task|
      @users_with_avatars[task.id] = avatars(task)
    end
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
    @comments = @task.comments.all
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def update
    @task = current_user.tasks.find(params[:id])
    if @task.update(task_params.merge(board_id: params[:board_id]))
      flash[:notice] = "タスクの編集に成功しました"
      redirect_to board_task_path(board_id: params[:board_id], id: @task)
    else
      flash.now[:alert] = "タスクの編集に失敗しました"
      render :edit
    end
  end

  def destroy
    task = current_user.tasks.find(params[:id])
    task.destroy!
    flash[:notice] = "タスクを削除しました"
    redirect_to board_tasks_path(board_id: params[:board_id])
  end

  private
  def task_params
    params.require(:task).permit(:name, :desc, :deadline, :image)
  end

  def avatars(task)
    avatars = []
    avatars << task.user.id

    comments = task.comments.all
    comments.each do |comment|
      if !avatars.include?(comment.user.id)
        avatars << comment.user.id
      end
    end

    avatars
  end

end