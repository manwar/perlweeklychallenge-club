#!/usr/bin/env ruby

def exact_change(arr)
  hash = Hash.new(0)
  arr.each do |n|
    if n == 10
      return false unless hash[5] -= 1
    elsif n == 20
      if hash[5] > 0 && hash[10] > 0
        hash[5] -= 1
        hash[10] -= 1
      elsif hash[5] > 2
        hash[5] -= 3
      else
        return false
      end
    end
    hash[n] += 1
  end
  true
end

p exact_change([5,5,5,10,20])
p exact_change([5,5,10,10,20])
p exact_change([5,5,5,20])

