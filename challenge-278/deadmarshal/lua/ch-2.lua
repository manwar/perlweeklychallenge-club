#!/usr/bin/env lua

local function reverse_string(s,e)
  assert(type(s) == 'string' and
	 type(e) == 'string','s and e must be strings!')
  local t,idx = {},string.find(s,e,1,true)
  if idx == nil then return s end
  for i=1,idx do t[#t+1] = s:sub(i,i) end
  table.sort(t)
  return table.concat(t,'') .. s:sub(idx+1,#s)
end

print(reverse_string('challenge','e'))
print(reverse_string('programming','a'))
print(reverse_string('champion','b'))

