#!/usr/bin/env lua

local function min_max(t)
  if #t < 3 then return -1 end
  local ret = {}
  local min,max = math.min(table.unpack(t)),math.max(table.unpack(t))
  for i=1,#t do
    if t[i] ~= min and t[i] ~= max then ret[#ret+1] = t[i] end
  end
  return table.concat(ret,' ')
end

print(min_max{3,2,1,4})
print(min_max{3,1})
print(min_max{2,1,3})

