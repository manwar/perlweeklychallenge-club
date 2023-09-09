#!/usr/bin/env ruby

def frequency_sort(arr)
  h = Hash.new(0)
  arr.each{|n| h[n] += 1}
  arr.sort{|a,b| h[a] == h[b] ? b - a : h[a] - h[b]}
end

p frequency_sort([1,1,2,2,2,3])
p frequency_sort([2,3,1,3,2])
p frequency_sort([-1,1,-6,4,5,-6,1,4,1])

