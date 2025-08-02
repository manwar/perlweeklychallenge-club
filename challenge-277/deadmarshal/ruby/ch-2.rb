#!/usr/bin/env ruby

def strong_pairs(arr)
  (arr.uniq.combination(2).select{|e| (e[0] - e[1]).abs < e.min}).size
end

p strong_pairs([1,2,3,4,5])
p strong_pairs([5,7,1,7])

