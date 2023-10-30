#!/usr/bin/env ruby

def array_loops(arr)
  count,indices = 0,[]
  arr.each do |i|
    next if indices[i]
    count += 1
    while not indices[i]
      indices[i] = 1
      i = arr[i]
    end
  end
  count
end

p array_loops([4,6,3,8,15,0,13,18,7,16,14,19,17,5,11,1,12,2,9,10])
p array_loops([0,1,13,7,6,8,10,11,2,14,16,4,12,9,17,5,3,18,15,19])
p array_loops([9,8,3,11,5,7,13,19,12,4,14,10,18,2,16,1,0,15,6,17])

