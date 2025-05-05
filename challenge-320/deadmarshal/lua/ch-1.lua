#!/usr/bin/env lua

local function maximum_count(t)
  assert(type(t) == 'table','t must be a table!')
  local neg,pos = 0,0
  for i=1,#t do
    if t[i] ~= 0 then
      if t[i] < 0 then neg = neg + 1
      else pos = pos + 1
      end
    end
  end
  return math.max(neg,pos)
end

print(maximum_count{-3,-2,-1,1,2,3})
print(maximum_count{-2,-1,0,0,1})
print(maximum_count{1,2,3,4})

