#!/usr/bin/env ruby

def min_max(arr)
  min,max = arr.min,arr.max
  arr.reject{|e| e == min or e == max}
end

p min_max([3,2,1,4]);
p min_max([3,1]);
p min_max([2,1,3]);

