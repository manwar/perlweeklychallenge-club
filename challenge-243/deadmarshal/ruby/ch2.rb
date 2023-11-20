#!/usr/bin/env ruby

def floor_sum(arr)
  sum = 0
  (0...arr.length).each do |i|
    (0...arr.length).each do |j|
      sum += (arr[i] / arr[j])
    end
  end
  return sum
end

p floor_sum([2,5,9])
p floor_sum([7,7,7,7,7,7,7])

