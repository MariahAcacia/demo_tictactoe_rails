class TicTacToeController < ApplicationController

  # set up brand new game board
  def new
    @current_player = 'X'
    @board = Board.new
    @board_arr = @board.board_arr
    save_player
    save_board_arr

    render :game_board
  end

  # Handle submitted moves, assume successful move for now
  def make_move
    @current_player = retrieve_current_player
    # make @board the only place where our board_arr lives for now so we don't get confused by @board_arr
    @board = Board.new(retrieve_board_arr)
    @board.add_piece(retrieve_coords, @current_player)

    # check for game-ending conditions
    @game_over = game_over_message

    # now pass our board arr back to the view and save everything we want to save
    @board_arr = @board.board_arr
    switch_player
    save_player
    save_board_arr

    render :game_board
  end

  private

  # switch current player
  def switch_player
    @current_player = (@current_player == 'X' ? 'O' : 'X')
  end

  # pull current player from the session
  def retrieve_current_player
    session[:current_player]
  end

  # save current player in session
  def save_player
    session[:current_player] = @current_player
  end

  # save board into the session
  def save_board_arr
    session[:saved_board_arr] = @board_arr
  end

  # pull board from session
  def retrieve_board_arr
    session[:saved_board_arr]
  end

  # grab and clean up the coords from our form submission
  def retrieve_coords
    params[:move].split(",").map(&:to_i)
  end

  def game_over_message
    if @board.winning_combo?(@current_player)
      @game_over = "Game over, player #{@current_player} WINS!"
    elsif @board.full?
      @game_over = "Game Over! You've drawn"
    end
  end

end
