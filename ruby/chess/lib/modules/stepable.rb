module Stepable
  def moves(board, pos)
    move_diffs.map { |dx, dy| [pos[0] + dx, pos[1] + dy] }
              .select { |p| board.valid_pos?(p) }
              .reject { |p| board[p] && board[p].color == self.color }
  end
end 