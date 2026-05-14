def merge_sort(arr)
  # Base case: arrays with 0 or 1 element are already sorted
  return arr if arr.length <= 1

  # Find the middle to divide the array
  mid = arr.length / 2
  
  # Recursively sort the left and right halves
  left_half = merge_sort(arr[0...mid])
  right_half = merge_sort(arr[mid...arr.length])

  # Delegate the merging logic to a helper method
  merge(left_half, right_half)
end

# Helper method to handle the merging of two sorted arrays
def merge(left, right)
  sorted_array = []

  # Compare the first elements of both arrays
  # Shift the smaller element into the sorted_array
  until left.empty? || right.empty?
    if left.first <= right.first
      sorted_array << left.shift
    else
      sorted_array << right.shift
    end
  end

  # If one array is emptied before the other, append the remainder
  # (Since the halves are already sorted, we can just tack the rest on the end)
  sorted_array + left + right
end

# --- Testing it out ---

puts "Merge Sort Tests:"
p merge_sort([])                                    # => []
p merge_sort([73])                                  # => [73]
p merge_sort([1, 2, 3, 4, 5])                       # => [1, 2, 3, 4, 5]
p merge_sort([3, 2, 1, 13, 8, 5, 0, 1])             # => [0, 1, 1, 2, 3, 5, 8, 13]
p merge_sort([105, 79, 100, 110])                   # => [79, 100, 105, 110]