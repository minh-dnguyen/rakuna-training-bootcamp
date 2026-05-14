# frozen_string_literal: true

require_relative 'node'

class Tree
  attr_reader :root

  def initialize(array)
    @root = build_tree(array.uniq.sort)
  end

  def pretty_print(node = @root, prefix = '', is_left: true)
    return unless node

    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", is_left: false)
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", is_left: true)
  end

  def include?(value)
    !find_node(@root, value).nil?
  end

  def insert(value)
    @root = insert_node(@root, value)
  end

  def delete(value)
    @root = delete_node(@root, value)
  end

  def level_order
    return to_enum(:level_order) unless block_given?
    return self if @root.nil?

    queue = [@root]
    until queue.empty?
      current = queue.shift
      yield current.data
      queue << current.left if current.left
      queue << current.right if current.right
    end
    self
  end

  def inorder(&block)
    return to_enum(:inorder) unless block_given?

    traverse_inorder(@root, &block)
    self
  end

  def preorder(&block)
    return to_enum(:preorder) unless block_given?

    traverse_preorder(@root, &block)
    self
  end

  def postorder(&block)
    return to_enum(:postorder) unless block_given?

    traverse_postorder(@root, &block)
    self
  end

  def height(value)
    target = find_node(@root, value)
    return nil unless target

    node_height(target)
  end

  def depth(value)
    current = @root
    edges = 0

    while current
      return edges if current.data == value

      current = if value < current.data
                  current.left
                else
                  current.right
                end
      edges += 1
    end
    nil
  end

  def balanced?(node = @root)
    return true if node.nil?

    left_height = node_height(node.left)
    right_height = node_height(node.right)

    return false if (left_height - right_height).abs > 1

    balanced?(node.left) && balanced?(node.right)
  end

  def rebalance
    values = inorder.to_a
    @root = build_tree(values)
  end

  private

  def build_tree(array)
    return nil if array.empty?

    mid = array.length / 2
    node = Node.new(array[mid])

    node.left = build_tree(array[0...mid])
    node.right = build_tree(array[(mid + 1)..])

    node
  end

  def find_node(node, value)
    return nil if node.nil?
    return node if node.data == value

    value < node.data ? find_node(node.left, value) : find_node(node.right, value)
  end

  def insert_node(node, value)
    return Node.new(value) if node.nil?

    if value < node.data
      node.left = insert_node(node.left, value)
    elsif value > node.data
      node.right = insert_node(node.right, value)
    end
    node
  end

  def delete_node(node, value)
    return node if node.nil?

    if value < node.data
      node.left = delete_node(node.left, value)
    elsif value > node.data
      node.right = delete_node(node.right, value)
    else
      # Node with only one child or no child
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      # Node with two children: Get inorder successor (smallest in right subtree)
      successor = min_value_node(node.right)
      node.data = successor.data
      node.right = delete_node(node.right, successor.data)
    end
    node
  end

  def min_value_node(node)
    current = node
    current = current.left while current.left
    current
  end

  def traverse_inorder(node, &block)
    return if node.nil?

    traverse_inorder(node.left, &block)
    yield node.data
    traverse_inorder(node.right, &block)
  end

  def traverse_preorder(node, &block)
    return if node.nil?

    yield node.data
    traverse_preorder(node.left, &block)
    traverse_preorder(node.right, &block)
  end

  def traverse_postorder(node, &block)
    return if node.nil?

    traverse_postorder(node.left, &block)
    traverse_postorder(node.right, &block)
    yield node.data
  end

  def node_height(node)
    return -1 if node.nil? # A leaf node will have a height of [-1, -1].max + 1 = 0

    left_height = node_height(node.left)
    right_height = node_height(node.right)
    [left_height, right_height].max + 1
  end
end
