#!/usr/bin/env lua

local function reverse_degree(s)
  assert(type(s) == 'string','s must be a string!')
  local sum,idx = 0,1
  for c in string.lower(s):gmatch("%a") do
    local v = 123 - string.byte(c)
    sum = sum + v * idx
    idx = idx + 1
  end
  return sum
end

print(reverse_degree('z'))
print(reverse_degree('a'))
print(reverse_degree('bbc'))
print(reverse_degree('racecar'))
print(reverse_degree('zyx'))

