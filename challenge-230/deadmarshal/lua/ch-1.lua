#!/usr/bin/env lua

local function separate_digits(t)
  local ret = {}
  for i=1,#t do
    for d in tostring(t[i]):gmatch(".") do ret[#ret+1] = d end
  end
  return ret
end

print(table.unpack(separate_digits{1,34,5,6}))
print(table.unpack(separate_digits{1,24,51,60}))

