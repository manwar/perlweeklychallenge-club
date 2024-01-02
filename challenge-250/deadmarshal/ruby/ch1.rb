#!/usr/bin/env ruby

def smallest_index(arr)
  (0..arr.length).map {|i| return i if i % 10 == arr[i]}
  -1
end

p smallest_index([0,1,2])
p smallest_index([4,3,2,1])
p smallest_index([1,2,3,4,5,6,7,8,9,0])

