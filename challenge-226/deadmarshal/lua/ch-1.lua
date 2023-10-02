#!/usr/bin/env lua

local function shuffle_string(str,t)
  assert(type(str) == 'string' and
	 type(t) == 'table',
	 'str and t must be a string and a table respectively!')
  local ret = {}
  for i=1, #t do
    ret[t[i]+1] = str:sub(i,i)
  end
  return table.concat(ret,'')
end

print(shuffle_string('lacelengh',{3,2,0,5,4,8,6,7,1}))
print(shuffle_string('rulepark',{4,7,3,1,0,5,2,6}))

