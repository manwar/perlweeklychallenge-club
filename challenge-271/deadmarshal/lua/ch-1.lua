#!/usr/bin/env lua

local function sum(t)
  assert(type(t) == 'table','t must be a table!')
  local s = 0
  for i=1,#t do s = s + t[i] end
  return s
end

local function maximum_ones(t)
  assert(type(t) == 'table','t must be a table!')
  local max = 0
  for i=1,#t do
    local s = sum(t[i])
    if s > max then max = s end
  end
  return max
end

print(maximum_ones{{0,1},{1,0}})
print(maximum_ones{{0,0,0},{1,0,1}})
print(maximum_ones{{0,0},{1,1},{0,0}})

