module Slideable
  HORIZONTAL_DIRS = [[0, -1], [0, 1], [-1, 0], [1, 0]]
  DIAGONAL_DIRS = [[-1, -1], [-1, 1], [1, -1], [1, 1]]

  def moves(board, pos)
    moves = []
    move_dirs.each do |dx, dy|
      cur_x, cur_y = pos[0] + dx, pos[1] + dy
      while board.valid_pos?([cur_x, cur_y])
        target = board[[cur_x, cur_y]]
        if target.nil?
          moves << [cur_x, cur_y]
        elsif target.color != self.color
          moves << [cur_x, cur_y]
          break # Blocked by enemy (can capture)
        else
          break # Blocked by own piece
        end
        cur_x, cur_y = cur_x + dx, cur_y + dy
      end
    end
    moves
  end
end