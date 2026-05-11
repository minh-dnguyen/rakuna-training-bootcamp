# frozen_string_literal: true

def bubble_sort(array)
  length = array.length
  pass = 0
  while pass < length
    index = 0
    while index < (length - 1)
      if array[index] > array[index + 1]
        temp = array[index]
        array[index] = array[index + 1]
        array[index + 1] = temp
      end
      index += 1
    end
    pass += 1
  end
  array
end

p bubble_sort([4, 3, 78, 2, 0, 2])
