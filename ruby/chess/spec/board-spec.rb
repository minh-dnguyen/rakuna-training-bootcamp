# frozen_string_literal: true

# Run with: rspec spec/board_spec.rb
require_relative '../chess' # Update path based on your folder structure

describe Board do
  subject(:board) { Board.new(false) } # Empty board

  describe '#checkmate?' do
    context "Fool's Mate scenario" do
      before do
        board[[0, 4]] = King.new(:black)
        board[[7, 4]] = King.new(:white)
        board[[3, 7]] = Queen.new(:black) # Black queen attacking
        board[[6, 5]] = Pawn.new(:white)
        board[[5, 6]] = Pawn.new(:white)
      end

      it 'declares checkmate for white' do
        expect(board.checkmate?(:white)).to be true
      end

      it 'does not declare checkmate for black' do
        expect(board.checkmate?(:black)).to be false
      end
    end

    context 'When king is in check but can escape' do
      before do
        board[[0, 4]] = King.new(:black)
        board[[7, 4]] = King.new(:white)
        board[[7, 3]] = Queen.new(:black) # Black queen putting white king in check
      end

      it 'declares check but not checkmate' do
        expect(board.check?(:white)).to be true
        expect(board.checkmate?(:white)).to be false
      end
    end
  end
end
