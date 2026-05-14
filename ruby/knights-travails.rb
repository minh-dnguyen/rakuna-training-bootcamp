# Returns all valid knight moves from a given position
def valid_moves(pos)
  # All possible L-shaped translations for a knight
  moves = [
    [1, 2], [2, 1], [-1, 2], [-2, 1],
    [1, -2], [2, -1], [-1, -2], [-2, -1]
  ]
  x, y = pos
  valid = []
  
  moves.each do |dx, dy|
    new_x, new_y = x + dx, y + dy
    # Only keep the move if it stays within the 8x8 board (coordinates 0-7)
    if new_x.between?(0, 7) && new_y.between?(0, 7)
      valid << [new_x, new_y]
    end
  end
  
  valid
end

def knight_moves(start_pos, end_pos)
  # The queue stores the entire path taken to reach a square, not just the square itself.
  # We initialize it with an array containing just the starting position.
  queue = [ [start_pos] ]
  
  # Keep track of visited squares to prevent infinite loops and redundant checks.
  visited = [start_pos]

  until queue.empty?
    # Dequeue the first path in line
    current_path = queue.shift
    current_node = current_path.last # The current position is the last square in the path

    # If we've reached our destination, print the result and return the path
    if current_node == end_pos
      puts "You made it in #{current_path.length - 1} moves!  Here's your path:"
      current_path.each { |square| p square }
      return current_path
    end

    # Otherwise, generate all valid next moves
    valid_moves(current_node).each do |move|
      unless visited.include?(move)
        visited << move # Mark as visited immediately so other paths don't queue it
        # Enqueue a new path array representing the journey so far PLUS this new move
        queue << current_path + [move]
      end
    end
  end
end

# Test Cases
puts "Test 1:"
knight_moves([0, 0], [1, 2])

puts "\nTest 2:"
knight_moves([3, 3], [4, 3])

puts "\nTest 3:"
knight_moves([0, 0], [7, 7])