#!usr/bin/env lua

local function special_numbers(t)
  assert(type(t) == 'table','t must be a number!')
  local sum = 0
  for i=1,#t do 
    if #t % i == 0 then sum = sum + t[i] * t[i] end
  end
  return sum
end

print(special_numbers{1,2,3,4})
print(special_numbers{2,7,1,19,18,3})
