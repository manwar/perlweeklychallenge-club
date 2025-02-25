#!/usr/bin/env ruby

def similar_dominos(arr)
  h = Hash.new(0)
  arr.each {|e| h[e.sort.join] += 1}
  (h.values.select {|e| e>1}).sum
end

puts similar_dominos([[1,3],[3,1],[2,4],[6,8]])
puts similar_dominos([[1,2],[2,1],[1,1],[1,2],[2,2]])
