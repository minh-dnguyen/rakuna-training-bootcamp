# frozen_string_literal: true

class Code
  COLORS = %w[red blue green yellow orange purple].freeze

  attr_reader :sequence

  def initialize(sequence)
    @sequence = sequence
  end

  def self.random
    new(Array.new(4) { COLORS.sample })
  end

  def compare(guess)
    exact_matches = 0
    color_matches = 0

    # Clone to avoid mutating original data during comparison
    temp_secret = @sequence.dup
    temp_guess = guess.dup

    # 1. Check for Exact Matches (Black Pegs)
    temp_guess.each_with_index do |color, i|
      next unless color == temp_secret[i]

      exact_matches += 1
      temp_secret[i] = nil
      temp_guess[i] = nil
    end

    # 2. Check for Color Matches (White Pegs)
    temp_guess.compact.each do |color|
      if temp_secret.include?(color)
        color_matches += 1
        temp_secret[temp_secret.index(color)] = nil
      end
    end

    { exact: exact_matches, color: color_matches }
  end

  def self.valid?(input)
    input.all? { |c| COLORS.include?(c) } && input.length == 4
  end
end
