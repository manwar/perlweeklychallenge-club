#!/usr/bin/env ruby

def bitwise_or(arr)
  arr.select{|e| e % 2 == 0}.size > 1
end

p bitwise_or([1,2,3,4,5])
p bitwise_or([2,3,8,16])
p bitwise_or([1,2,5,7,9])

