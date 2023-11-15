#!/usr/bin/env lua

local function floor_sum(t)
  assert(type(t) == 'table','t must be a table!')
  local sum = 0
  for i=1,#t do
    for j=1,#t do
      sum = sum + (t[i] // t[j])
    end
  end
  return sum
end

print(floor_sum{2,5,9})
print(floor_sum{7,7,7,7,7,7,7})

