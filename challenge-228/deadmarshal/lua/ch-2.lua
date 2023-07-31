#!/usr/bin/env lua

local function empty_array(t)
  local count = 0
  while #t ~= 0 do
    if t[1] == math.min(table.unpack(t)) then table.remove(t,1)
    else table.insert(t,table.remove(t,1)) end
    count = count + 1
  end
  return count
end

print(empty_array({3,4,2}))
print(empty_array({1,2,3}))

