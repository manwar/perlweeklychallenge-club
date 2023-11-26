#!/usr/bin/env lua

local function disjoint_sets(t1,t2)
  assert(type(t1) == 'table' and
	 type(t2) == 'table','t1,t2 must be tables!')
  local h = {}
  for i=1,#t1 do
    h[t1[i]] = (h[t1[i]] or 0) + 1
    h[t2[i]] = (h[t2[i]] or 0) + 1
  end
  for _,v in pairs(h) do
    if v > 1 then return false end
  end
  return true
end

print(disjoint_sets({1,2,5,3,4},{4,6,7,8,9}))
print(disjoint_sets({1,3,5,7,9},{0,2,4,6,8}))

