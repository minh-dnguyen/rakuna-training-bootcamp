# frozen_string_literal: true

require_relative 'piece'
require_relative '../modules/stepable'

class King < Piece
  include Stepable

  def initialize(color)
    super(color, color == :white ? '♔' : '♚')
  end

  def move_diffs
    [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
  end

  def moves(board, pos)
    possible_moves = super(board, pos)

    # Castling Logic
    unless @moved || board.check?(@color)
      row = @color == :white ? 7 : 0
      enemy = @color == :white ? :black : :white

      # Kingside Castling
      k_rook = board[[row, 7]]
      if k_rook.is_a?(Rook) && !k_rook.moved && board[[row, 5]].nil? && board[[row, 6]].nil? &&
         !board.square_threatened?([row, 5], enemy) &&
         !board.square_threatened?([row, 6], enemy)
        possible_moves << [row, 6]
      end

      # Queenside Castling
      q_rook = board[[row, 0]]
      if q_rook.is_a?(Rook) && !q_rook.moved && board[[row, 1]].nil? && board[[row, 2]].nil? && board[[row, 3]].nil? &&
         !board.square_threatened?([row, 2], enemy) &&
         !board.square_threatened?([row, 3], enemy)
        possible_moves << [row, 2]
      end
    end

    possible_moves
  end
end
