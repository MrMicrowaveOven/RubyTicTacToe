class ComputerPlayer
  attr_reader :boards_this_game, :previous_boards
  def initialize
    @boards_this_game = [];
    @previous_boards = Hash.new(0)
  end

  def make_move(board)
    board_string = ""
    board.spaces.each do |row|
      row.each do |space|
        if space == ""
          board_string += " "
        else
          board_string += space
        end
      end
    end

    # scores is the number scores for the potential moves
    scores = []
    # moves is the potential moves (int)
    moves = []
    # boards is the potential boards "xoox ox x"
    boards = []
    board_string.chars.each_with_index do |char, char_index|
      if char == " "
        potential_move = board_string.slice(0, char_index) + "o" + board_string.slice(char_index + 1 .. -1).to_s
        scores << @previous_boards[potential_move]
        moves << char_index
        boards << potential_move
      end
    end
    best_move_score = scores.max
    move_index = scores.index(best_move_score)
    move_int = moves[move_index]
    @boards_this_game << boards[move_index]
    [move_int / 3, move_int % 3]
  end

  def update_score(board, winner)
    @boards_this_game.each do |board_this_game|
      if winner
        @previous_boards[board_this_game] += 1
      else
        @previous_boards[board_this_game] -= 1
      end
    end
    # @boards_this_game[]
  end
end
