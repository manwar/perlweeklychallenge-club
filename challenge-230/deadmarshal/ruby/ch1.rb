#!/usr/bin/env ruby

def separate_digits(arr)
  ret = []
  arr.map do |n|
    n.to_s.split('').each {|e| ret << e.to_i}
  end
  ret
end

p separate_digits([1,34,5,6])
p separate_digits([1,24,51,60])

