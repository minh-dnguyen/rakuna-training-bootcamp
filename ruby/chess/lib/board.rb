# frozen_string_literal: true

require_relative 'pieces/piece'
require_relative 'pieces/king'
require_relative 'pieces/queen'
require_relative 'pieces/rook'
require_relative 'pieces/bishop'
require_relative 'pieces/knight'
require_relative 'pieces/pawn'

class Board
  attr_reader :grid, :history

  def initialize(fill_board = true)
    @grid = Array.new(8) { Array.new(8) }
    @history = []
    setup_board if fill_board
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, piece)
    row, col = pos
    @grid[row][col] = piece
  end

  def valid_pos?(pos)
    pos.all? { |coord| coord.between?(0, 7) }
  end

  def move_piece(color, start_pos, end_pos)
    piece = self[start_pos]
    raise 'No piece there' if piece.nil?
    raise 'Not your piece' if piece.color != color
    raise 'Invalid move' unless piece.moves(self, start_pos).include?(end_pos)
    raise 'Move leaves King in check' unless valid_move?(start_pos, end_pos)

    # 1. Castling Execution (Move the Rook too)
    if piece.is_a?(King) && (start_pos[1] - end_pos[1]).abs == 2
      row = start_pos[0]
      if end_pos[1] == 6 # Kingside
        self[[row, 5]] = self[[row, 7]]
        self[[row, 7]] = nil
      elsif end_pos[1] == 2 # Queenside
        self[[row, 3]] = self[[row, 0]]
        self[[row, 0]] = nil
      end
    end

    # 2. En Passant Execution (Remove the bypassed pawn)
    self[[start_pos[0], end_pos[1]]] = nil if piece.is_a?(Pawn) && start_pos[1] != end_pos[1] && self[end_pos].nil?

    # Log move history
    @history << { piece: piece, start_pos: start_pos, end_pos: end_pos }

    # Execute main move
    self[end_pos] = piece
    self[start_pos] = nil
    piece.moved = true

    # 3. Pawn Promotion
    return unless piece.is_a?(Pawn) && [0, 7].include?(end_pos[0])

    self[end_pos] = Queen.new(color)
    puts 'Pawn automatically promoted to Queen!'
  end

  def valid_move?(start_pos, end_pos)
    piece = self[start_pos]
    target = self[end_pos]

    self[end_pos] = piece
    self[start_pos] = nil

    in_check = check?(piece.color)

    self[start_pos] = piece
    self[end_pos] = target

    !in_check
  end

  def check?(color)
    king_pos = find_king(color)
    enemy_color = color == :white ? :black : :white

    pieces(enemy_color).any? do |enemy_pos, enemy_piece|
      # A King can never deliver check to another King.
      # Skip it to prevent infinite recursion!
      next false if enemy_piece.is_a?(King)

      enemy_piece.moves(self, enemy_pos).include?(king_pos)
    end
  end

  def checkmate?(color)
    return false unless check?(color)

    pieces(color).all? do |start_pos, piece|
      piece.moves(self, start_pos).none? { |end_pos| valid_move?(start_pos, end_pos) }
    end
  end

  def stalemate?(color)
    !check?(color) && pieces(color).all? do |start_pos, piece|
      piece.moves(self, start_pos).none? { |end_pos| valid_move?(start_pos, end_pos) }
    end
  end

  def square_threatened?(pos, enemy_color)
    pieces(enemy_color).any? do |start_pos, piece|
      if piece.is_a?(King)
        # Instead of calling piece.moves, we just use math to see if the
        # enemy king is exactly 1 square away in any direction.
        row_diff = (start_pos[0] - pos[0]).abs
        col_diff = (start_pos[1] - pos[1]).abs
        row_diff <= 1 && col_diff <= 1
      else
        piece.moves(self, start_pos).include?(pos)
      end
    end
  end

  def pieces(color)
    found = []
    8.times do |row|
      8.times do |col|
        p = self[[row, col]]
        found << [[row, col], p] if p && p.color == color
      end
    end
    found
  end

  def find_king(color)
    pieces(color).find { |_, piece| piece.is_a?(King) }.first
  end

  def display
    puts '  0 1 2 3 4 5 6 7'
    @grid.each_with_index do |row, i|
      print "#{i} "
      row.each { |p| print p ? "#{p} " : '. ' }
      puts
    end
  end

  private

  def setup_board
    %i[white black].each do |color|
      pawn_row = color == :white ? 6 : 1
      back_row = color == :white ? 7 : 0

      8.times { |c| self[[pawn_row, c]] = Pawn.new(color) }
      self[[back_row, 0]] = Rook.new(color)
      self[[back_row, 7]] = Rook.new(color)
      self[[back_row, 1]] = Knight.new(color)
      self[[back_row, 6]] = Knight.new(color)
      self[[back_row, 2]] = Bishop.new(color)
      self[[back_row, 5]] = Bishop.new(color)
      self[[back_row, 3]] = Queen.new(color)
      self[[back_row, 4]] = King.new(color)
    end
  end
end
