# frozen_string_literal: true

require_relative 'piece'
require_relative '../modules/slideable'

class Bishop < Piece
  include Slideable

  def initialize(color)
    super(color, color == :white ? '♗' : '♝')
  end

  def move_dirs
    DIAGONAL_DIRS
  end
end
