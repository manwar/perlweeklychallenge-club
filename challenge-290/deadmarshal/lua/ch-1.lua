#!/usr/bin/env lua

local function double_exist(t)
  assert(type(t) == 'table','t must be a table!')
  local h = {}
  for i=1,#t do h[t[i]] = 1 end
  for k,_ in pairs(h) do if h[k * 2] ~= nil then return true end end
  return false
end

print(double_exist{6,2,3,3})
print(double_exist{3,1,4,13})
print(double_exist{2,1,4,2})

