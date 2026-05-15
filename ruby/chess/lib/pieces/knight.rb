# frozen_string_literal: true

require_relative 'piece'
require_relative '../modules/stepable'

class Knight < Piece
  include Stepable

  def initialize(color)
    super(color, color == :white ? '♘' : '♞')
  end

  def move_diffs
    [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]]
  end
end
