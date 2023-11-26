#!/usr/bin/env ruby

def conflict_intervals(arr)
  ret = []
  (1...arr.length).each do |i|
    b = false
    (0...i).each do |j|
      b = true if arr[i][0] >= arr[j][0] and arr[i][0] <= arr[j][1]
    end
    ret.push(arr[i]) if b
  end
  ret
end

p conflict_intervals([[1,4],[3,5],[6,8],[12,13],[3,20]])
p conflict_intervals([[3,4],[5,7],[6,9],[10,12],[13,15]])

