#!/usr/bin/env ruby

def sort_by_one_bits(arr)
  arr.sort do |a,b|
    pa = a.digits(2).count(1)
    pb = b.digits(2).count(1)
    pa == pb ? a <=> b : pa <=> pb
  end
end

p sort_by_one_bits([0,1,2,3,4,5,6,7,8])
p sort_by_one_bits([1024,512,256,128,64])

