require_relative 'hash_map'

# 1. Create a new instance of your hash map
test = HashMap.new
puts "Initial Capacity: #{test.capacity}"

# 2. Populate the hash map
test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')

puts "\n--- After Populating 12 Items ---"
puts "Length: #{test.length}"
puts "Capacity: #{test.capacity}" # Should still be 16

# 3. Overwriting nodes
test.set('apple', 'DARK RED')
test.set('dog', 'BLACK AND BROWN')

puts "\n--- After Overwriting ---"
puts "Length: #{test.length}" # Should still be 12
puts "Apple is now: #{test.get('apple')}"
puts "Dog is now: #{test.get('dog')}"

# 4. Triggering growth
test.set('moon', 'silver')

puts "\n--- After Adding 13th Item (Triggers Resize) ---"
puts "Length: #{test.length}"
puts "Capacity: #{test.capacity}" # Should now be 32

# 5. Overwriting nodes in the expanded hash map
test.set('moon', 'GLOWING SILVER')
puts "\n--- After Overwriting in Expanded Map ---"
puts "Moon is now: #{test.get('moon')}"
puts "Length is still: #{test.length}"

# 6. Testing other methods
puts "\n--- Testing Other Methods ---"
puts "Has 'lion'?: #{test.has?('lion')}" # true
puts "Has 'tiger'?: #{test.has?('tiger')}" # false

puts "Removing 'hat': #{test.remove('hat')}" # returns 'black'
puts "Has 'hat' now?: #{test.has?('hat')}" # false
puts "Length after removal: #{test.length}" # 12

puts "\nKeys: #{test.keys}"
puts "\nValues: #{test.values}"
puts "\nEntries: #{test.entries}"

test.clear
puts "\n--- After Clear ---"
puts "Length: #{test.length}" # 0
puts "Entries: #{test.entries}" # []