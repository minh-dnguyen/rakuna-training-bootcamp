# frozen_string_literal: true

require_relative 'linked_list'

# 1. Create an instance of LinkedList
list = LinkedList.new

# 2. Populate it with nodes
list.append('dog')
list.append('cat')
list.append('parrot')
list.append('hamster')
list.append('snake')
list.append('turtle')

# 3. Print the list
puts 'Initial List:'
puts list
# Expected: ( dog ) -> ( cat ) -> ( parrot ) -> ( hamster ) -> ( snake ) -> ( turtle ) -> nil

puts "\n--- Testing Standard Methods ---"
puts "Size: #{list.size}"                     # Expected: 6
puts "Head: #{list.head}"                     # Expected: dog
puts "Tail: #{list.tail}"                     # Expected: turtle
puts "Node at index 2: #{list.at(2)}"         # Expected: parrot
puts "Contains 'snake'?: #{list.contains?('snake')}" # Expected: true
puts "Index of 'hamster': #{list.index('hamster')}"  # Expected: 3

puts "\nPopping the head node: #{list.pop}"   # Expected: dog
puts 'List after pop:'
puts list                                     # Expected: starts with cat

puts "\n--- Testing Extra Credit ---"
puts "Inserting 'iguana' and 'gecko' at index 2:"
list.insert_at(2, 'iguana', 'gecko')
puts list
# Expected: ( cat ) -> ( parrot ) -> ( iguana ) -> ( gecko ) -> ( hamster ) -> ( snake ) -> ( turtle ) -> nil

puts "\nRemoving node at index 4 ('hamster'):"
list.remove_at(4)
puts list
# Expected: ( cat ) -> ( parrot ) -> ( iguana ) -> ( gecko ) -> ( snake ) -> ( turtle ) -> nil
