#!/usr/bin/env lua

local function smallest_index(t)
  assert(type(t) == 'table','t must be a table!')
  for i=1,#t do
    if i % 10 == t[i]+1 then return i-1 end
  end
  return -1
end

print(smallest_index{0,1,2})
print(smallest_index{4,3,2,1})
print(smallest_index{1,2,3,4,5,6,7,8,9,0})

