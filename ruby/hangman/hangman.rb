require 'json'

class Hangman
  attr_accessor :secret_word, :word_progress, :incorrect_guesses, :guesses_left

  def initialize
    @secret_word = select_random_word
    @word_progress = Array.new(@secret_word.length, '_')
    @incorrect_guesses = []
    @guesses_left = 8
  end

  # Selects a random word between 5 and 12 characters from the dictionary
  def select_random_word
    # Using __dir__ ensures it looks for the txt file in the same folder as this script
    dictionary_path = File.join(__dir__, 'google-10000-english-no-swears.txt')
    
    unless File.exist?(dictionary_path)
      puts "Error: 'google-10000-english-no-swears.txt' not found at #{dictionary_path}."
      exit
    end

    words = File.readlines(dictionary_path).map(&:chomp)
    valid_words = words.select { |word| word.length.between?(5, 12) }
    valid_words.sample.downcase
  end

  # Main game loop
  def play
    puts "\n--- Welcome to Hangman! ---"
    
    until game_over?
      display_status
      puts "\nEnter a letter to guess, or type 'save' to save your game:"
      input = gets.chomp.downcase

      if input == 'save'
        save_game
        puts "Game saved! Thanks for playing."
        return
      elsif valid_guess?(input)
        process_guess(input)
      else
        puts "Invalid input. Please enter a single letter you haven't guessed yet."
      end
    end

    end_game_message
  end

  private

  def display_status
    puts "\n======================================"
    puts "Word: #{@word_progress.join(' ')}"
    puts "Incorrect Guesses: #{@incorrect_guesses.join(', ')}"
    puts "Guesses Remaining: #{@guesses_left}"
  end

  # Validates the guess to ensure fairness and good user experience.
  def valid_guess?(input)
    # Condition 1: Must be exactly one lowercase letter (no numbers/symbols).
    is_a_letter = input.match?(/^[a-z]$/)
    
    # Condition 2: Prevents unfair penalty. If they already guessed 'z' and it was wrong,
    # we shouldn't let them guess it again and lose another life for a typo or memory lapse.
    not_guessed_incorrectly = !@incorrect_guesses.include?(input)
    
    # Condition 3: Prevents wasted turns. If they already correctly guessed 'e',
    # guessing 'e' again does nothing to advance the game. We force them to pick a new letter.
    not_guessed_correctly = !@word_progress.include?(input)
    
    is_a_letter && not_guessed_incorrectly && not_guessed_correctly
  end

  def process_guess(letter)
    if @secret_word.include?(letter)
      puts "\nGood guess!"
      @secret_word.chars.each_with_index do |char, index|
        @word_progress[index] = letter if char == letter
      end
    else
      puts "\nIncorrect guess."
      @incorrect_guesses << letter
      @guesses_left -= 1
    end
  end

  def game_over?
    @guesses_left.zero? || !@word_progress.include?('_')
  end

  def end_game_message
    if @word_progress.include?('_')
      puts "\nGame Over! You ran out of guesses."
      puts "The secret word was: #{@secret_word}"
    else
      puts "\nCongratulations! You guessed the word: #{@secret_word}"
    end
  end

  # --- Serialization (Save/Load) Methods ---

  def save_game
    save_dir = File.join(__dir__, 'saves')
    save_file = File.join(save_dir, 'saved_game.json')
    
    Dir.mkdir(save_dir) unless Dir.exist?(save_dir)
    
    game_data = JSON.dump({
      secret_word: @secret_word,
      word_progress: @word_progress,
      incorrect_guesses: @incorrect_guesses,
      guesses_left: @guesses_left
    })

    File.open(save_file, 'w') { |file| file.write(game_data) }
  end

  def self.load_game
    save_file = File.join(__dir__, 'saves', 'saved_game.json')
    
    unless File.exist?(save_file)
      puts "No saved game found. Starting a new game..."
      return new
    end

    file = File.read(save_file)
    data = JSON.parse(file)

    game = new
    game.secret_word = data['secret_word']
    game.word_progress = data['word_progress']
    game.incorrect_guesses = data['incorrect_guesses']
    game.guesses_left = data['guesses_left']
    
    puts "Game loaded successfully!"
    game
  end
end

# --- Game Initialization Menu ---

puts "Welcome to Hangman!"
puts "1. Start a New Game"
puts "2. Load a Saved Game"
print "Enter your choice (1 or 2): "
choice = gets.chomp

if choice == '2'
  game = Hangman.load_game
else
  game = Hangman.new
end

game.play