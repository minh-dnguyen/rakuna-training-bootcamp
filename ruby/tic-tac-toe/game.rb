# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

class Game
  def initialize
    @board = Board.new
    setup_players
    @current_player = @player1
  end

  def play
    puts "\n--- Welcome to Tic-Tac-Toe! ---"
    @board.display

    loop do
      take_turn
      @board.display

      break if game_over?

      switch_player
    end
  end

  private

  def setup_players
    puts 'Enter name for Player 1 (X):'
    name1 = gets.chomp
    @player1 = Player.new(name1, 'X')

    puts 'Enter name for Player 2 (O):'
    name2 = gets.chomp
    @player2 = Player.new(name2, 'O')
  end

  def take_turn
    success = false
    until success
      puts "#{@current_player.name} (#{@current_player.marker}), choose a position (1-9):"
      # Subtract 1 to convert the user's 1-9 input to a 0-8 array index
      input = gets.chomp.to_i - 1

      if @board.update(input, @current_player.marker)
        success = true
      else
        puts 'Invalid move! The spot is either taken or out of bounds. Try again.'
      end
    end
  end

  def switch_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def game_over?
    if (winning_marker = @board.winner)
      winner = winning_marker == @player1.marker ? @player1 : @player2
      puts "🎉 Congratulations #{winner.name}! You win!"
      true
    elsif @board.full?
      puts "It's a draw! Well played both."
      true
    else
      false
    end
  end
end
