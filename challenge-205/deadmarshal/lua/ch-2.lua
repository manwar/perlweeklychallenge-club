#!/usr/bin/env lua

local function maximum_xor(t)
  assert(type(t) == 'table','t must be a table!')
  local max = 0
  for i=1,#t do
    for j=1,#t do
      if max < t[i] ~ t[j] then max = t[i] ~ t[j] end
    end
  end
  return max
end

print(maximum_xor({1,2,3,4,5,6,7}))
print(maximum_xor({2,4,1,3}))
print(maximum_xor({10,5,7,12,8}))

