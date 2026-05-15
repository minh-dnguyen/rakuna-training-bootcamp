# frozen_string_literal: true

module Slideable
  HORIZONTAL_DIRS = [[0, -1], [0, 1], [-1, 0], [1, 0]].freeze
  DIAGONAL_DIRS = [[-1, -1], [-1, 1], [1, -1], [1, 1]].freeze

  def moves(board, pos)
    moves = []
    move_dirs.each do |dx, dy|
      cur_x = pos[0] + dx
      cur_y = pos[1] + dy
      while board.valid_pos?([cur_x, cur_y])
        target = board[[cur_x, cur_y]]
        if target.nil?
          moves << [cur_x, cur_y]
        elsif target.color != color
          moves << [cur_x, cur_y]
          break # Blocked by enemy (can capture)
        else
          break # Blocked by own piece
        end
        cur_x += dx
        cur_y += dy
      end
    end
    moves
  end
end
