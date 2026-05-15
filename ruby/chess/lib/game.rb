# frozen_string_literal: true

require 'yaml'
require_relative 'board'

class Game
  def initialize(ai_enabled = false)
    @board = Board.new
    @current_player = :white
    @ai_enabled = ai_enabled
  end

  def play
    loop do
      @board.display
      puts "#{@current_player.capitalize}'s turn."

      if @board.checkmate?(@current_player)
        puts "Checkmate! #{@current_player == :white ? :black : :white} wins!"
        break
      elsif @board.stalemate?(@current_player)
        puts 'Stalemate! The game is a draw.'
        break
      elsif @board.check?(@current_player)
        puts 'You are in check!'
      end

      if @ai_enabled && @current_player == :black
        take_ai_turn
      else
        take_human_turn
      end

      @current_player = @current_player == :white ? :black : :white
    end
  end

  def take_human_turn
    puts "Options: [Move: '6,0 to 5,0'] | [Save: 'save'] | [Quit: 'quit'] | [Save & Quit: 'sq']"
    print '> '
    input = gets.chomp.downcase

    # Handle menu commands
    case input
    when 'save'
      save_game
      puts 'Game saved! Continuing...'
      return take_human_turn
    when 'quit', 'exit'
      puts 'Thanks for playing! Goodbye.'
      exit # Instantly terminates the Ruby script
    when 'save quit', 'sq'
      save_game
      puts 'Game saved successfully. Thanks for playing! Goodbye.'
      exit
    end

    # Handle standard movement
    start_str, end_str = input.split(' to ')

    # Basic validation to prevent crashing if the user types nonsense
    unless start_str && end_str && start_str.include?(',') && end_str.include?(',')
      raise "Please use the correct format (e.g., '6,0 to 5,0')"
    end

    start_pos = start_str.split(',').map(&:to_i)
    end_pos = end_str.split(',').map(&:to_i)

    @board.move_piece(@current_player, start_pos, end_pos)
  rescue StandardError => e
    puts "Error: #{e.message}. Try again."
    retry # Loops back to the 'begin' block to let them try again
  end

  def take_ai_turn
    puts 'AI is thinking...'
    sleep(1)

    pieces = @board.pieces(:black)
    valid_moves_map = {}

    pieces.each do |pos, piece|
      legal_moves = piece.moves(@board, pos).select { |end_pos| @board.valid_move?(pos, end_pos) }
      valid_moves_map[pos] = legal_moves unless legal_moves.empty?
    end

    start_pos = valid_moves_map.keys.sample
    end_pos = valid_moves_map[start_pos].sample

    puts "AI moved from #{start_pos} to #{end_pos}"
    @board.move_piece(:black, start_pos, end_pos)
  end

  def save_game
    File.open('saved_game.yml', 'w') { |file| file.write(YAML.dump(self)) }
  end

  def self.load_game
    if File.exist?('saved_game.yml')
      YAML.safe_load(File.read('saved_game.yml'))
    else
      puts 'No saved game found! Starting a new game instead.'
      Game.new
    end
  end
end
