class BoardsController < ApplicationController
  before_action :set_board, only: :show
  def new
    @board = Board.new
  end

  def create
    begin
      @board = MineSweeperBoard.new(params).call
      flash[:success] = "Board created successfully!"
      redirect_to board_path(@board)
    rescue Exception => e
      flash[:error] = e.message
      redirect_to root_path
    end
  end

  def show; end

  def index
    @boards = Board.paginate(page: params[:page], per_page: 10).order(created_at: :desc)
  end

  private

  def set_board
    @board = Board.find_by_id(params[:id])
    handle_board_not_found if @board.nil?
  end

  def handle_board_not_found
    flash[:error] = "Board not found against id: #{params[:id]}"
    redirect_to boards_path
  end
end
