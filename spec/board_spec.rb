require_relative '../lib/board.rb'

describe "board" do
  describe "make_move" do
    it "makes a move at specified location, of specified player" do
      board = Board.new
      expect(board.spaces).to eql([[" ", " ", " "],[" ", " ", " "],[" ", " ", " "]])
      board.make_move([1,1], "o")
      expect(board.spaces).to eql([[" ", " ", " "],[" ", "o", " "],[" ", " ", " "]])
    end
  end
  describe "valid_move?" do
    before :each do
      @board = Board.new([["x", "x", "x"],[" ", "o", " "],[" ", " ", "x"]])
    end
    it "returns false if space is occupied" do
      expect(@board.valid_move?([1,1])).to eq(false)
    end
    it "returns false if space is invalid" do
      expect(@board.valid_move?([5,1])).to eq(false)
      expect(@board.valid_move?([-1,1])).to eq(false)
    end
    it "returns true if space is empty" do
      expect(@board.valid_move?([1,0])).to eq(true)
    end
  end
  describe "winner" do
    it "returns winning player when game has been won horizontally" do
      board = Board.new([["x", "x", "x"],[" ", "o", " "],[" ", " ", "x"]])
      expect(board.winner).to eql("x")
    end
    it "returns winning player when game has been won vertially" do
      board = Board.new([[" ", "x", " "],[" ", "x", " "],[" ", "x", " "]])
      expect(board.winner).to eql("x")
    end
    it "returns winning player when game has been won diagonal down-right" do
      board = Board.new([["o", " ", " "],[" ", "o", " "],[" ", "x", "o"]])
      expect(board.winner).to eql("o")
    end
    it "returns winning player when game has been won diagonal up-right" do
      board = Board.new([["o", " ", "x"],[" ", "x", " "],["x", "x", "o"]])
      expect(board.winner).to eql("x")
    end
    it "returns false when there is no winner" do
      board = Board.new([["o", "o", "x"],[" ", "o", " "],["x", "x", " "]])
      expect(board.winner).to eql(false)
    end
  end

  describe "draw?" do
    it "returns false if a move can still be made" do
      board = Board.new([["o", "o", "x"],["x", "o", "x"],["x", "x", " "]])
      expect(board.draw?).to eql(false)
    end
    it "returns true if board is full" do
      board = Board.new([["o", "o", "x"],["x", "o", "x"],["x", "x", "o"]])
      expect(board.draw?).to eql(true)
    end
  end
end
