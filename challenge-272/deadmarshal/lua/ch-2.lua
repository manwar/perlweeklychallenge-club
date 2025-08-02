#!/usr/bin/env lua

local function string_score(str)
  assert(type(str) == 'string','str must be a string!')
  local sum = 0
  for i=1,#str-1 do
    sum = sum + math.abs(string.byte(str:sub(i+1,i+1))
			 - string.byte(str:sub(i,i)))
  end
  return sum
end

print(string_score('hello'))
print(string_score('perl'))
print(string_score('raku'))

