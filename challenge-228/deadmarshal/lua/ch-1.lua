#!/usr/bin/env lua

local function unique_sum(t)
  local hash,sum = {},0
  setmetatable(hash,{__index = function(t,k) return 0 end})
  for i=1,#t do
    hash[t[i]] = hash[t[i]] + 1
  end
  for k,v in pairs(hash) do
    if v == 1 then sum = sum + k end
  end
  return sum
end

print(unique_sum({2,1,3,2}))
print(unique_sum({1,1,1,1}))
print(unique_sum({2,1,3,4}))

