module Enumerable
  # Your code goes here
  def my_all?
    my_each do |element|
      return false unless yield(element)
    end
    true
  end

  def my_any?
    my_each do |element|
      return true if yield(element)
    end
    false
  end

  def my_count
    count = 0
    if block_given?
      my_each { |element| count += 1 if yield(element) }
    else
      my_each { count += 1 }
    end
    count
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?
    
    index = 0
    my_each do |element|
      yield(element, index)
      index += 1
    end
    self
  end

  def my_inject
    accumulator = nil
    my_each do |element|
      if accumulator.nil?
        # If no initial value is provided, the first element becomes the accumulator
        accumulator = element
      else
        accumulator = yield(accumulator, element)
      end
    end
    accumulator
  end

  def my_map
    return to_enum(:my_map) unless block_given?
    
    result = []
    my_each do |element|
      result << yield(element)
    end
    result
  end

  def my_none?
    my_each do |element|
      return false if yield(element)
    end
    true
  end

  def my_select
    return to_enum(:my_select) unless block_given?
    
    result = []
    my_each do |element|
      result << element if yield(element)
    end
    result
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  def my_each
    return to_enum(:my_each) unless block_given?
    
    for element in self
      yield(element)
    end
    self
  end
end