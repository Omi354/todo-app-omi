class BoardsController < ApplicationController

  def index
    @boards = Board.all
  end

  def new
    if user_signed_in?
      @board = current_user.boards.build
    else
      flash.now[:alert] = "ログインして下さい"
      @boards = Board.all
      render :index
    end
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      flash[:notice] = "Boardを作成しました"
      redirect_to boards_path
    else
      flash.now[:alert] = "作成に失敗しました"
      render :new
    end
  end

  def edit
    @board = current_user.boards.find(params[:id])
  end

  def update
    @board = current_user.boards.find(params[:id])
    if @board.update(board_params)
      flash[:notice] = "Boardを更新しました"
      redirect_to boards_path
    else
      flash.now[:alert] = "更新に失敗しました"
      render :edit
    end
  end

  def destroy
    board = current_user.boards.find(params[:id])
    board.destroy!
    flash[:notice] = "Boardを削除しました"
    redirect_to boards_path
  end

  private
  def board_params
    params.require(:board).permit(:title, :desc)
  end
end
