# frozen_string_literal: true

require_relative '../board'

RSpec.describe Board do
  describe '#update' do
    it 'places a marker on a valid empty position' do
      board = Board.new

      expect(board.update(0, 'X')).to be true
      expect(board.instance_variable_get(:@cells)[0]).to eq('X')
    end

    it 'returns false when the position is already taken' do
      board = Board.new
      board.update(0, 'X')

      expect(board.update(0, 'O')).to be false
    end

    it 'returns false for an out-of-bounds position' do
      board = Board.new

      expect(board.update(9, 'X')).to be false
      expect(board.update(-1, 'O')).to be false
    end
  end

  describe '#full?' do
    it 'returns false when the board still has empty spaces' do
      board = Board.new

      expect(board.full?).to be false
    end

    it 'returns true when all board positions are filled' do
      board = Board.new
      (0..8).each { |index| board.update(index, 'X') }

      expect(board.full?).to be true
    end
  end

  describe '#winner' do
    it 'returns X when X wins across the top row' do
      board = Board.new
      board.update(0, 'X')
      board.update(1, 'X')
      board.update(2, 'X')

      expect(board.winner).to eq('X')
    end

    it 'returns O when O wins down the first column' do
      board = Board.new
      board.update(0, 'O')
      board.update(3, 'O')
      board.update(6, 'O')

      expect(board.winner).to eq('O')
    end

    it 'returns X when X wins on a diagonal' do
      board = Board.new
      board.update(0, 'X')
      board.update(4, 'X')
      board.update(8, 'X')

      expect(board.winner).to eq('X')
    end

    it 'returns nil when there is no winning combination' do
      board = Board.new
      board.update(0, 'X')
      board.update(1, 'O')
      board.update(2, 'X')

      expect(board.winner).to be_nil
    end

    it 'returns nil when the board is full but the game is a draw' do
      board = Board.new
      markers = %w[X O X X X O O X O]
      markers.each_with_index { |marker, index| board.update(index, marker) }

      expect(board.full?).to be true
      expect(board.winner).to be_nil
    end
  end
end
