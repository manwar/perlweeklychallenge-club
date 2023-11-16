#!/usr/bin/env ruby

def reverse_pairs(arr)
  count = 0
  (0...arr.length-1).each do |i|
    (i+1...arr.length).each do |j|
      count += 1 if arr[i] > (2 * arr[j])
    end
  end
  return count
end

p reverse_pairs([1,3,2,3,1])
p reverse_pairs([2,4,3,5,1])

