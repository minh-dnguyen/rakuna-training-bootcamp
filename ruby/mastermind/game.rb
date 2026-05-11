# frozen_string_literal: true

require_relative 'code'
require_relative 'player'

class Game
  MAX_TURNS = 12

  def initialize
    setup_game
  end

  def setup_game
    puts 'Welcome to Mastermind! Do you want to be the (1) Maker or (2) Guesser?'
    choice = gets.chomp
    if choice == '1'
      @creator = HumanPlayer.new(:creator)
      @guesser = ComputerPlayer.new(:guesser)
    else
      @creator = ComputerPlayer.new(:creator)
      @guesser = HumanPlayer.new(:guesser)
    end
  end

  def play
    secret_seq = @creator.create_code
    @secret_code = Code.new(secret_seq)

    puts "\nGame Start! The Maker has set the code."
    feedback = nil

    1.upto(MAX_TURNS) do |turn|
      puts "\n--- Turn #{turn} ---"

      guess = @guesser.is_a?(ComputerPlayer) ? @guesser.get_guess(feedback) : @guesser.get_guess
      @guesser.store_last_guess(guess) if @guesser.is_a?(ComputerPlayer)

      puts "Guesser chose: #{guess.join(', ')}"

      feedback = @secret_code.compare(guess)
      display_feedback(feedback)

      if feedback[:exact] == 4
        puts 'Game Over! The Guesser cracked the code!'
        return
      end
    end

    puts "Game Over! The Maker wins. The code was: #{secret_seq.join(', ')}"
  end

  private

  def display_feedback(fb)
    puts "Feedback: #{fb[:exact]} Exact Matches (Black), #{fb[:color]} Color Matches (White)"
  end
end
