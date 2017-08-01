require_relative '../lib/computer_player'

describe "computer_player" do
  describe "get_computer_move" do
    before :each do
      @board = Board.new([["x", " ", " "],[" ", "o", " "],[" ", " ", "x"]])
      @computer_player = ComputerPlayer.new
    end
    it "makes a valid move based on the board" do
      computers_move = @computer_player.get_computer_move(@board)
      expect(computers_move).to eq([0,1])
    end
    it "stores board appropriately" do
      computers_move = @computer_player.get_computer_move(@board)
      expect(@computer_player.instance_variable_get(:@boards_this_game)).to eq(["xo  o   x"])
    end
  end

  describe "update_score" do
    before :each do
      @board = Board.new([["x", " ", " "],[" ", "o", " "],[" ", " ", "x"]])
      @computer_player = ComputerPlayer.new
      computers_move = @computer_player.get_computer_move(@board)
      @board.make_move(computers_move, "o")
      @board.make_move([0,2], "x")
      computers_move = @computer_player.get_computer_move(@board)
      @board.make_move(computers_move, "o")
    end
    it "if computer won, increases the score of all the boards used in the game" do
      @computer_player.update_score(@board, true)
      expect(@computer_player.instance_variable_get(:@previous_boards)).to eq({
        "xo  o   x" => 1,
        "xoxoo   x" => 1
      })
    end
    it "if computer lost, decrease the score of all the boards used in the game" do
      @computer_player.update_score(@board, false)
      expect(@computer_player.instance_variable_get(:@previous_boards)).to eq({
        "xo  o   x" => -1,
        "xoxoo   x" => -1
      })
    end
  end
  describe "computer_player AI" do
    it "chooses the first move with the best score" do
      @computer_player = ComputerPlayer.new
      @computer_player.instance_variable_set(:@previous_boards, {
        "o   x    " => -1,
        " o  x    " => -5,
        "  o x    " => 10,
        "   ox    " => 8,
        "    xo   " => 2,
        "    x o  " => 0,
        "    x  o " => 1,
        "    x   o" => 10,
      })
      @board = Board.new([[" ", " ", " "],[" ", "x", " "],[" ", " ", " "]])
      expect(@computer_player.get_computer_move(@board)).to eq([0,2])
    end
  end

  describe "AI memory" do
    it "remembers previous games" do
      @board = Board.new([[" ", " ", " "],[" ", "x", " "],[" ", " ", " "]])
      @computer_player = ComputerPlayer.new

      computers_move = @computer_player.get_computer_move(@board)
      expect(computers_move).to eq([0,0])
      @board.make_move(computers_move, "o")
      @board.make_move([0,1], "x")

      computers_move = @computer_player.get_computer_move(@board)
      expect(computers_move).to eq([0,2])
      @board.make_move(computers_move, "o")
      @board.make_move([2,1], "x")

      @computer_player.update_score(@board, false)

      @board = Board.new([[" ", " ", " "],[" ", "x", " "],[" ", " ", " "]])
      computers_move = @computer_player.get_computer_move(@board)
      expect(computers_move).to eq([0,1])
    end
  end
end
