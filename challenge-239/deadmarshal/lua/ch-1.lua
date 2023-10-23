#!/usr/bin/env lua

local function same_string(t1,t2)
  assert(type(t1) == 'table' and
	 type(t2) == 'table','t1,t2 must be tables!')
  return table.concat(t1) == table.concat(t2)
end

print(same_string({"ab","c"},{"a","bc"}))
print(same_string({"ab","c"},{"ac","b"}))
print(same_string({"ab","cd","e"},{"abcde"}))

