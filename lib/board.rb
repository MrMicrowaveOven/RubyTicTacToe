class Board
  attr_reader :spaces
  def initialize(spaces = [["", "", ""],["", "", ""],["", "", ""]])
    @spaces = spaces
  end

  def make_move(space, x_or_o)
    @spaces[space[0]][space[1]] = x_or_o
  end

  def winner
    # Horizontal
    @spaces.each do |row|
      if row[0] == row[1] && row[1] == row[2] &&  row[0] != ""
        return row[0]
      end
    end
    # Vertical
    3.times do |column_index|
      if @spaces[0][column_index] == @spaces[1][column_index] && @spaces[1][column_index] == @spaces[2][column_index] && @spaces[0][column_index] != ""
        return @spaces[0][column_index]
      end
    end
    # Diagonal Down-Right
    if @spaces[0][0] == @spaces[1][1] && @spaces[1][1] == @spaces[2][2] && @spaces[0][0] != ""
      return @spaces[0][0]
    end
    # Diagonal Up-Right
    if @spaces[2][0] == @spaces[1][1] && @spaces[1][1] == @spaces[0][2] && @spaces[2][0] != ""
      return @spaces[2][0]
    end
    false
  end

  def draw?
    @spaces.each do |row|
      row.each do |space|
        if space == ""
          return false
        end
      end
    end
    true
  end
end
