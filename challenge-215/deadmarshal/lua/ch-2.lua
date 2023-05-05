#!/usr/bin/env lua

local function number_placement(t,count)
  if #t < 3 then return false end
  local c = 0
  for i=1,#t-1 do
    if t[i-1] == 0 and t[i+1] == 0 then c = c + 1 end
  end
  return c >= count
end

print(number_placement({1,0,0,0,1},1))
print(number_placement({1,0,0,0,1},2))
print(number_placement({1,0,0,0,0,0,0,0,1},3))

