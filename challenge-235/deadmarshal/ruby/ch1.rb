#!/usr/bin/env ruby

def remove_one(arr)
  c1,c2,idx1,idx2 = 0,0,-1,-1
  (1..arr.length()-1).each do |i|
    if arr[i] <= arr[i-1]
      c1 += 1
      idx1 = i-1
    end
  end
  (1..arr.length()-2).to_a.reverse.each do |i|
    if arr[i] <= arr[i-1]
      c2 += 1
      idx1 = i+1
    end
  end
  return true if c1 == 1 && c2 == 1 && idx2 - idx1 + 1 == 2
  return false if c1 > 1 || c2 > 1
  return true
end

p remove_one([0,2,9,4,5])
p remove_one([5,1,3,2])
p remove_one([2,2,3])

