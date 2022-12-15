#!/usr/bin/env lua
-- luarocks install stdlib
local std = require'std'

local function is_uniq(t)
  for i=1, #t do
    for j=i+1, #t do
      if t[i] == t[j] then return false end
    end
  end
  return true
end

local function most_frequent_even(t)
  if #std.functional.filter(std.functional.lambda('|e| e % 2 ~= 0'),
			    std.elems,t) == #t then
    return -1
  end
  t = std.functional.filter(std.functional.lambda('|e| e % 2 == 0'),
			    std.elems,t)
  local hash = {}
  setmetatable(hash,{__index = function(t,k) return 0 end})
  for i=1,#t do hash[t[i]] = hash[t[i]] + 1 end
  if is_uniq(std.table.values(hash)) then
    return math.min(std.table.unpack(std.table.keys(hash)))
  end
  local sorted = std.table.okeys(hash)
  for i=1,#sorted-1 do
    if hash[sorted[i]] == hash[sorted[i+1]] then
      return sorted[i]
    end
  end
end

print(most_frequent_even({1,1,2,6,2}))
print(most_frequent_even({1,3,5,7}))
print(most_frequent_even({6,4,4,6,1}))

