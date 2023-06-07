class MineSweeperBoard

  MINE = 1
  EMPTY_CELL = 0

  def initialize(params)
    @params = params
    @height = board_params[:height].to_i
    @width = board_params[:width].to_i
    @num_of_mines = board_params[:num_mines].to_i
  end

  def call
    @board = Board.new(board_params)
    @board.board_data = board_data_with_mines
    @board.save!
    @board
  end

  private

  def board_data_with_mines
    board = Array.new(@height) { Array.new(@width, EMPTY_CELL) }
    positions = (0...@height).to_a.product((0...@width).to_a)
    positions.shuffle!
    positions.take(@num_of_mines).each { |x, y| board[x][y] = MINE }
    board
  end

  def board_params
    @params.require(:board).permit(:name, :email, :width, :height, :num_mines)
  end
end
