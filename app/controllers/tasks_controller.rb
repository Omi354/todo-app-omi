class TasksController < ApplicationController
  def index
    @tasks = Task.where(board_id: params[:board_id])
  end
end