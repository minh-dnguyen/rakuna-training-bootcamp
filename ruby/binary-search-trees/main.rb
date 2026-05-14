# frozen_string_literal: true

require_relative 'tree'

# 1. Create a binary search tree from an array of random numbers
random_numbers = Array.new(15) { rand(1..100) }
tree = Tree.new(random_numbers)

puts '--- Initial Tree ---'
tree.pretty_print

# 2. Confirm that the tree is balanced
puts "\nIs the tree balanced? #{tree.balanced?}"

# 3. Print out all elements in level, pre, post, and in order
puts "\nLevel-order: #{tree.level_order.to_a}"
puts "Pre-order:   #{tree.preorder.to_a}"
puts "Post-order:  #{tree.postorder.to_a}"
puts "In-order:    #{tree.inorder.to_a}"

# 4. Unbalance the tree by adding several numbers > 100
puts "\n--- Unbalancing the tree ---"
[105, 120, 150, 134, 189].each { |num| tree.insert(num) }
tree.pretty_print

# 5. Confirm that the tree is unbalanced
puts "\nIs the tree balanced? #{tree.balanced?}"

# 6. Balance the tree by calling #rebalance
puts "\n--- Rebalancing the tree ---"
tree.rebalance
tree.pretty_print

# 7. Confirm that the tree is balanced
puts "\nIs the tree balanced? #{tree.balanced?}"

# 8. Print out all elements in level, pre, post, and in order again
puts "\nLevel-order: #{tree.level_order.to_a}"
puts "Pre-order:   #{tree.preorder.to_a}"
puts "Post-order:  #{tree.postorder.to_a}"
puts "In-order:    #{tree.inorder.to_a}"
