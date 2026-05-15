require_relative 'piece'

class Pawn < Piece
  def initialize(color)
    super(color, color == :white ? "♙" : "♟")
  end

  def moves(board, pos)
    dir = @color == :white ? -1 : 1
    moves = []
    forward = [pos[0] + dir, pos[1]]
    
    if board.valid_pos?(forward) && board[forward].nil?
      moves << forward
      
      # Double Step (if hasn't moved and path is clear)
      double_forward = [pos[0] + (dir * 2), pos[1]]
      if !@moved && board[double_forward].nil?
        moves << double_forward
      end
    end
    
    # Captures & En Passant
    [[dir, -1], [dir, 1]].each do |dx, dy|
      diag = [pos[0] + dx, pos[1] + dy]
      next unless board.valid_pos?(diag)

      if board[diag] && board[diag].color != @color
        moves << diag 
      else
        # En Passant Capture
        last_move = board.history.last
        if last_move && last_move[:piece].is_a?(Pawn) && last_move[:piece].color != @color
          enemy_start, enemy_end = last_move[:start_pos], last_move[:end_pos]
          if (enemy_start[0] - enemy_end[0]).abs == 2 && enemy_end == [pos[0], pos[1] + dy]
            moves << diag
          end
        end
      end
    end
    
    moves
  end
end