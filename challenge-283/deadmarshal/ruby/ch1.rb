#!/usr/bin/env ruby

def unique_number(arr)
  arr.uniq.find{|e| arr.count(e) == 1}
end

puts unique_number([3,3,1])
puts unique_number([3,2,4,2,4])
puts unique_number([1])
puts unique_number([4,3,1,1,1,4])

