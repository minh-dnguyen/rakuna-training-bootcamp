# frozen_string_literal: true

require_relative 'piece'
require_relative '../modules/slideable'

class Rook < Piece
  include Slideable

  def initialize(color)
    super(color, color == :white ? '♖' : '♜')
  end

  def move_dirs
    HORIZONTAL_DIRS
  end
end
