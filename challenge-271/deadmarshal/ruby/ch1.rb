#!/usr/bin/env ruby

def maximum_ones(arr)
  max = 0
  arr.each_with_index {|e,i| max = i+1 if e.sum > max}
  max
end

p maximum_ones([[0,1],[1,0]])
p maximum_ones([[0,0,0],[1,0,1]])
p maximum_ones([[0,0],[1,1],[0,0]])

