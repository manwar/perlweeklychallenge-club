#!/usr/bin/env ruby

def duplicate_zeros(arr)
  ret = []
  for e in arr
    break if ret.length() == arr.length()
    e == 0 ? ret.push(0,0) : ret.push(e)
  end
  ret
end

p duplicate_zeros([1,0,2,3,0,4,5,0])
p duplicate_zeros([1,2,3])
p duplicate_zeros([0,3,0,4,5])

