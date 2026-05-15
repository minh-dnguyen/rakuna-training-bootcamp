require_relative 'lib/game'

puts "Welcome to Chess!"
puts "1. New Game (PvP)"
puts "2. New Game (vs AI)"
puts "3. Load Game"
print "> "
choice = gets.chomp

game = case choice
       when "2" then Game.new(true)
       when "3" then Game.load_game
       else Game.new
       end

game.play