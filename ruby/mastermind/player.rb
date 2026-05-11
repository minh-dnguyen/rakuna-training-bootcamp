# frozen_string_literal: true

require_relative 'code'

class Player
  attr_reader :role

  def initialize(role)
    @role = role # :creator or :guesser
  end
end

class HumanPlayer < Player
  def create_code
    puts 'Enter 4 colors for your secret code (red, blue, green, yellow, orange, purple):'
    loop do
      input = gets.chomp.downcase.split
      return input if Code.valid?(input)

      puts 'Invalid input. Pick 4 colors from the list.'
    end
  end

  def get_guess
    create_code # The logic is the same for guessing
  end
end

class ComputerPlayer < Player
  def initialize(role)
    super
    @possible_codes = Code::COLORS.repeated_permutation(4).to_a if @role == :guesser
  end

  def create_code
    Array.new(4) { Code::COLORS.sample }
  end

  def get_guess(feedback = nil)
    # Simple strategy: If no feedback, guess random.
    # If feedback exists, filter possible codes that would have given that same feedback.
    return %w[red red blue blue] if feedback.nil?

    last_guess = @last_guess
    @possible_codes.select! do |potential|
      potential_code_obj = Code.new(potential)
      potential_code_obj.compare(last_guess) == feedback
    end

    @last_guess = @possible_codes.sample
  end

  def store_last_guess(guess)
    @last_guess = guess
  end
end
