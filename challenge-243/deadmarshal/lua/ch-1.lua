#!/usr/bin/env lua

local function reverse_pairs(t)
  assert(type(t) == 'table','t must be a table!')
  local count = 0
  for i=1,#t-1 do
    for j=i+1,#t do
      if t[i] > 2 * t[j] then count = count + 1 end
    end
  end
  return count
end

print(reverse_pairs{1,3,2,3,1})
print(reverse_pairs{2,4,3,5,1})

