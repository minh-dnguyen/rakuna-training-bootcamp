# Iterative Approach
def fibs(n)
  return [] if n <= 0
  return [0] if n == 1
  
  sequence = [0, 1]
  
  (n - 2).times do
    sequence << sequence[-1] + sequence[-2]
  end
  
  sequence
end

# Recursive Approach
def fibs_rec(n)
  puts 'This was printed recursively'
  
  # Base cases
  return [] if n <= 0
  return [0] if n == 1
  return [0, 1] if n == 2
  
  # Recursive step
  sequence = fibs_rec(n - 1)
  
  sequence << sequence[-1] + sequence[-2]
end

# --- Testing it out ---

puts "Iterative Test (n = 8):"
p fibs(8) # => [0, 1, 1, 2, 3, 5, 8, 13]

puts "\nRecursive Test (n = 8):"
p fibs_rec(8) # => [0, 1, 1, 2, 3, 5, 8, 13]

puts "\nTesting various lengths (Recursive):"
p fibs_rec(1) # => [0]
p fibs_rec(3) # => [0, 1, 1]
p fibs_rec(5) # => [0, 1, 1, 2, 3]