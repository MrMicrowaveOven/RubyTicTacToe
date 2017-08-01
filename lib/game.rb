require_relative 'board.rb'

class Game
  def initialize
    @computer_player = ComputerPlayer.new
    start_new_game
  end

  def start_new_game
    @game_board = Board.new
    puts "Welcome to Tic-Tac-Toe!"
    puts "Where would you like to move?"
    p @game_board
    get_moves
  end

  def get_moves
    while true
      if @game_board.winner || @game_board.draw?
        break
      end
      move = get_move
      @game_board.make_move(move, "x")
      p @game_board
      if @game_board.winner || @game_board.draw?
        break
      end
      move = @computer_player.get_move(@game_board)
      @game_board.make_move(move, "o")
      p @game_board
    end
    game_over
  end

  def game_over
    if @game_board.winner == "o"
      @computer_player.update_score(@game_board, true)
    elsif @game_board.winner == "o"
      @computer_player.update_score(@game_board, false)
    end
    show_game_end
  end

  def show_game_end
    if @game_board.winner
      puts "#{@game_board.winner} is the winner!"
    else
      puts "Game is a draw!"
    end
    start_new_game
  end

  def get_move
    y_of_move = gets.chomp
    x_of_move = gets.chomp
    [y_of_move.to_i, x_of_move.to_i]
  end
end
