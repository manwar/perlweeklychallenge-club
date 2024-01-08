#!/usr/bin/env lua

local function alphanumeric_string_value(t)
  assert(type(t) == 'table','t must be a table!')
  local max = 0
  for i=1,#t do
    local n = t[i]:match('^%d+$') and tonumber(t[i]) or t[i]:len()
    if n > max then max = n end
  end
  return max
end

print(alphanumeric_string_value{'perl','2','000','python','r4ku'})
print(alphanumeric_string_value{'001','1','000','0001'})

