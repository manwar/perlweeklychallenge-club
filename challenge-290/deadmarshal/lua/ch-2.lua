#!/usr/bin/env lua

local function luhns_algorithm(str)
  assert(type(str) == 'string','str must be a string!')
  str = str:gsub("%s+","")
  local p = tonumber(str:sub(#str,#str))
  str = str:sub(1,#str-1)
  local s,even = 0,false
  for i=#str,1,-1 do
    local d = tonumber(str:sub(i,i))
    if even then s = s + d
    else if 2 * d > 9 then s = s + (2 * d - 9) else s = s + 2 * d end
    end
    even = not even
  end
  return (s + p) % 10 == 0
end

print(luhns_algorithm('17893729974'))
print(luhns_algorithm('4137 8947 1175 5904'))
print(luhns_algorithm('4137 8974 1175 5904'))

