# frozen_string_literal: true

class LinkedList
  def initialize
    @head_node = nil
  end

  def append(value)
    if @head_node.nil?
      @head_node = Node.new(value)
    else
      current = @head_node
      current = current.next_node while current.next_node
      current.next_node = Node.new(value)
    end
  end

  def prepend(value)
    @head_node = Node.new(value, @head_node)
  end

  def size
    count = 0
    current = @head_node
    while current
      count += 1
      current = current.next_node
    end
    count
  end

  def head
    @head_node&.value
  end

  def tail
    return nil if @head_node.nil?

    current = @head_node
    current = current.next_node while current.next_node
    current.value
  end

  def at(index)
    return nil if index.negative? || @head_node.nil?

    current = @head_node
    index.times do
      return nil if current.next_node.nil?

      current = current.next_node
    end
    current.value
  end

  # NOTE: Standard CS 'pop' removes the tail, but as per your instructions,
  # this removes the head node and returns its value.
  def pop
    return nil if @head_node.nil?

    popped_value = @head_node.value
    @head_node = @head_node.next_node
    popped_value
  end

  def contains?(value)
    current = @head_node
    while current
      return true if current.value == value

      current = current.next_node
    end
    false
  end

  def index(value)
    idx = 0
    current = @head_node
    while current
      return idx if current.value == value

      current = current.next_node
      idx += 1
    end
    nil
  end

  def to_s
    return '' if @head_node.nil?

    result = []
    current = @head_node
    while current
      result << "( #{current.value} )"
      current = current.next_node
    end
    result << 'nil'
    result.join(' -> ')
  end

  # --- Extra Credit Methods ---

  def insert_at(index, *values)
    raise IndexError, 'Index out of bounds' if index.negative? || index > size
    return if values.empty?

    # Create new nodes and link them together
    new_nodes = values.map { |v| Node.new(v) }
    new_nodes.each_cons(2) { |a, b| a.next_node = b }

    first_new_node = new_nodes.first
    last_new_node = new_nodes.last

    if index.zero?
      last_new_node.next_node = @head_node
      @head_node = first_new_node
    else
      # Find the node right before our insertion point
      prev_node = @head_node
      (index - 1).times { prev_node = prev_node.next_node }

      # Connect the chain
      last_new_node.next_node = prev_node.next_node
      prev_node.next_node = first_new_node
    end
  end

  def remove_at(index)
    raise IndexError, 'Index out of bounds' if index.negative? || index >= size

    if index.zero?
      @head_node = @head_node.next_node
    else
      # Find the node right before the one we want to remove
      prev_node = @head_node
      (index - 1).times { prev_node = prev_node.next_node }

      # Bypass the removed node
      prev_node.next_node = prev_node.next_node.next_node
    end
  end
end
