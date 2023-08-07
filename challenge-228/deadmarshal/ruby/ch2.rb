#!/usr/bin/env ruby

def empty_array(arr)
  count = 0
  while arr.length != 0
    arr[0] == arr.min ? arr.shift : arr.push(arr.shift)
    count += 1
  end
  count
end

puts empty_array([3,4,2])
puts empty_array([1,2,3])

