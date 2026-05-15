class Piece
  attr_reader :color, :symbol
  attr_accessor :moved
  
  def initialize(color, symbol)
    @color = color
    @symbol = symbol
    @moved = false
  end
  
  def to_s
    @symbol
  end
end