#!/usr/bin/env lua

local function str_split(str)
  local res = {}
  str:gsub(".", function(c) table.insert(res,c) end)
  return res 
end
    
local function is_alphabetical_order(s)
  local t = str_split(s)
  for i=2,#t do
    if t[i] < t[i-1] then return false end
  end
  return true
end

local function odd_one_out(t)
  local count = 0
  for i=1,#t do
    if not is_alphabetical_order(t[i]) then count = count + 1 end
  end
  return count
end

print(odd_one_out({'abc', 'xyz', 'tsu'}))
print(odd_one_out({'rat', 'cab', 'dad'}))
print(odd_one_out({'x','y','z'}))

