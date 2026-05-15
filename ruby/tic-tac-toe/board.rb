# frozen_string_literal: true

class Board
  # All possible winning index combinations
  WINNING_COMBOS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], # Rows
    [0, 3, 6], [1, 4, 7], [2, 5, 8], # Columns
    [0, 4, 8], [2, 4, 6]             # Diagonals
  ].freeze

  def initialize
    @cells = Array.new(9, ' ')
  end

  def display
    puts ''
    puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
    puts '---+---+---'
    puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
    puts '---+---+---'
    puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
    puts ''
  end

  # Attempts to place a marker. Returns true if successful, false if invalid.
  def update(position, marker)
    if valid_move?(position)
      @cells[position] = marker
      true
    else
      false
    end
  end

  def full?
    @cells.none? { |cell| cell == ' ' }
  end

  # Returns the winning marker ("X" or "O") if there's a winner, otherwise nil.
  def winner
    WINNING_COMBOS.each do |combo|
      if @cells[combo[0]] != ' ' &&
         @cells[combo[0]] == @cells[combo[1]] &&
         @cells[combo[1]] == @cells[combo[2]]
        return @cells[combo[0]]
      end
    end
    nil
  end

  private

  def valid_move?(position)
    position.between?(0, 8) && @cells[position] == ' '
  end
end
