#!/usr/bin/env lua

local function ttos(t)
  assert(type(t) == 'table','t must be a table!')
  local s = ''
  for i=1,#t do s = s .. tostring(t[i]) end
  return s
end

local function similar_dominos(t)
  assert(type(t) == 'table','t must be a table!')
  local h,sum = {},0
  for i=1,#t do
    table.sort(t[i])
    local s = ttos(t[i])
    h[s] = (h[s] or 0) + 1
  end
  for k,v in pairs(h) do if v > 1 then sum = sum + v end end
  return sum
end

print(similar_dominos{{1,3},{3,1},{2,4},{6,8}})
print(similar_dominos{{1,2},{2,1},{1,1},{1,2},{2,2}})

