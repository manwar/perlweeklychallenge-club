#!/usr/bin/env lua

local function good_pairs(t)
  assert(type(t) == 'table','t must be a table!')
  local count = 0
  for i=1,#t do
    for j=i+1,#t do
      if t[i] == t[j] then count = count + 1 end
    end
  end
  return count
end

print(good_pairs({1,2,3,1,1,3}))
print(good_pairs({1,2,3}))
print(good_pairs({1,1,1,1}))

