require_relative '../lib/computer_player'

describe "computer_player" do
  describe "make_move" do
    before :each do
      @board = Board.new([["x", "", ""],["", "o", ""],["", "", "x"]])
      @computer_player = ComputerPlayer.new
    end
    it "makes a valid move based on the board" do
      computers_move = @computer_player.make_move(@board)
      expect(computers_move).to eq([0,1])
    end
    it "stores board appropriately" do
      computers_move = @computer_player.make_move(@board)
      expect(@computer_player.boards_this_game).to eq(["xo  o   x"])
    end
  end

  describe "update_score" do
    before :each do
      @board = Board.new([["x", "", ""],["", "o", ""],["", "", "x"]])
      @computer_player = ComputerPlayer.new
      computers_move = @computer_player.make_move(@board)
      @board.make_move(computers_move, "o")
      @board.make_move([0,2], "x")
      computers_move = @computer_player.make_move(@board)
      @board.make_move(computers_move, "o")
    end
    it "if computer won, increases the score of all the boards used in the game" do
      @computer_player.update_score(@board, true)
      expect(@computer_player.previous_boards).to eq({
        "xo  o   x" => 1,
        "xoxoo   x" => 1
      })
    end
    it "if computer lost, decrease the score of all the boards used in the game" do
      @computer_player.update_score(@board, false)
      expect(@computer_player.previous_boards).to eq({
        "xo  o   x" => -1,
        "xoxoo   x" => -1
      })
    end
  end
end
