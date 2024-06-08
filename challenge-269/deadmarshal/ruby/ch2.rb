#!/usr/bin/env ruby

def distribute_elements(arr)
  ret1 = [arr.shift()]
  ret2 = [arr.shift()]
  while arr.size() > 0
    e = arr.shift()
    ret1[-1] > ret2[-1] ? ret1.push(e) : ret2.push(e)
  end
  ret1 + ret2
end

p distribute_elements([2,1,3,4,5])
p distribute_elements([3,2,4])
p distribute_elements([5,4,3,8])

