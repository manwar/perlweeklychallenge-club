#!/usr/bin/env lua

local function running_sum(t)
  assert(type(t) == 'table','t must be a table!')
  local ret = {}
  local sum = 0
  for i=1,#t do
    sum = sum + t[i]
    ret[#ret+1] = sum
  end
  return ret
end

print(table.unpack(running_sum{1,2,3,4,5}))
print(table.unpack(running_sum{1,1,1,1,1}))
print(table.unpack(running_sum{0,-1,1,2}))

