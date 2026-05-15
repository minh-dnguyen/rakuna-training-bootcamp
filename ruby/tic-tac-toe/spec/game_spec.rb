# frozen_string_literal: true

require_relative '../game'
require_relative '../player'

RSpec.describe Game do
  describe '#game_over?' do
    let(:player1) { instance_double(Player, name: 'Alice', marker: 'X') }
    let(:player2) { instance_double(Player, name: 'Bob', marker: 'O') }
    let(:board) { instance_double('Board') }
    let(:game) do
      game = Game.allocate
      game.instance_variable_set(:@board, board)
      game.instance_variable_set(:@player1, player1)
      game.instance_variable_set(:@player2, player2)
      game.instance_variable_set(:@current_player, player1)
      game
    end

    it 'returns true and announces the correct winner when player1 wins' do
      allow(board).to receive(:winner).and_return('X')
      allow(board).to receive(:full?).and_return(false)
      expect(game).to receive(:puts).with('🎉 Congratulations Alice! You win!')

      expect(game.send(:game_over?)).to be true
    end

    it 'returns true and announces the correct winner when player2 wins' do
      allow(board).to receive(:winner).and_return('O')
      allow(board).to receive(:full?).and_return(false)
      expect(game).to receive(:puts).with('🎉 Congratulations Bob! You win!')

      expect(game.send(:game_over?)).to be true
    end

    it 'returns true and announces a draw when the board is full with no winner' do
      allow(board).to receive(:winner).and_return(nil)
      allow(board).to receive(:full?).and_return(true)
      expect(game).to receive(:puts).with("It's a draw! Well played both.")

      expect(game.send(:game_over?)).to be true
    end

    it 'returns false when the game is not over' do
      allow(board).to receive(:winner).and_return(nil)
      allow(board).to receive(:full?).and_return(false)
      expect(game).not_to receive(:puts)

      expect(game.send(:game_over?)).to be false
    end
  end

  describe '#switch_player' do
    it 'switches current player from player1 to player2 and back again' do
      player1 = instance_double(Player, name: 'Alice', marker: 'X')
      player2 = instance_double(Player, name: 'Bob', marker: 'O')
      game = Game.allocate
      game.instance_variable_set(:@player1, player1)
      game.instance_variable_set(:@player2, player2)
      game.instance_variable_set(:@current_player, player1)

      game.send(:switch_player)
      expect(game.instance_variable_get(:@current_player)).to eq(player2)

      game.send(:switch_player)
      expect(game.instance_variable_get(:@current_player)).to eq(player1)
    end
  end

  describe '#take_turn' do
    it 'keeps asking until a valid move is made and shows invalid move messages' do
      board = instance_double('Board')
      allow(board).to receive(:update).with(0, 'X').and_return(false)
      allow(board).to receive(:update).with(1, 'X').and_return(true)

      player = instance_double(Player, name: 'Alice', marker: 'X')
      game = Game.allocate
      game.instance_variable_set(:@board, board)
      game.instance_variable_set(:@current_player, player)

      expect(game).to receive(:puts).with('Alice (X), choose a position (1-9):').ordered
      expect(game).to receive(:gets).and_return("1\n").ordered
      expect(game).to receive(:puts).with('Invalid move! The spot is either taken or out of bounds. Try again.').ordered
      expect(game).to receive(:puts).with('Alice (X), choose a position (1-9):').ordered
      expect(game).to receive(:gets).and_return("2\n").ordered

      game.send(:take_turn)
    end
  end
end
