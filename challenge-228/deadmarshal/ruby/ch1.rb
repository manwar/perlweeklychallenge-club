#!/usr/bin/env ruby

def unique_sum(arr)
  hash = Hash.new(0)
  arr.each {|n| hash[n] += 1}
  hash.keys.select {|k| hash[k] == 1}.sum
end

puts unique_sum([2,1,3,2])
puts unique_sum([1,1,1,1])
puts unique_sum([2,1,3,4])

