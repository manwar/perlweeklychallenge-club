#!/usr/bin/env ruby

def digit_count_value(arr)
  h = Hash.new(0)
  arr.each{|e| h[e] += 1}
  i = 0
  arr.all?{|e| h[i] == e && i += 1}
end

puts digit_count_value([1,2,1,0])
puts digit_count_value([0,3,0])

