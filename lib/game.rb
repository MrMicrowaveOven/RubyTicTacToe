require_relative 'board.rb'
require_relative 'computer_player.rb'

class Game
  def begin_game
    system("clear")
    @computer_player = ComputerPlayer.new
    while true
      start_new_game
      get_moves
      game_over
    end
  end

  def start_new_game
    @game_board = Board.new
    puts "Welcome to Tic-Tac-Toe!"
    p @game_board
  end

  def get_moves
    while true
      if @game_board.winner || @game_board.draw?
        break
      end
      move = false
      until @game_board.valid_move?(move)
        puts "Where would you like to move?"
        move = get_move
        if !@game_board.valid_move?(move)
          puts "Invalid move."
        end
      end
      @game_board.make_move(move, "x")
      p @game_board
      if @game_board.winner || @game_board.draw?
        break
      end
      puts "Computer's turn!"
      sleep(2)
      move = @computer_player.get_computer_move(@game_board)
      system("clear")
      puts "Computer's move: #{move}"
      @game_board.make_move(move, "o")
      p @game_board
    end
  end

  def game_over
    if @game_board.winner == "o"
      @computer_player.update_score(@game_board, true)
    elsif @game_board.winner == "x"
      @computer_player.update_score(@game_board, false)
    end
    show_game_end
  end

  def show_game_end
    system("clear")
    p @game_board
    if @game_board.winner
      puts "#{@game_board.winner} is the winner!"
    else
      puts "Game is a draw!"
    end
    puts "Let's play again!"
  end

  def get_move
    puts "Which column?"
    y_of_move = gets.chomp
    puts "Which row?"
    x_of_move = gets.chomp
    [y_of_move.to_i, x_of_move.to_i]
  end
end
