#!/usr/bin/env lua

local function friendly_strings(s1,s2)
  assert(type(s1) == 'string' and
	 type(s2) == 'string',
	 's1 and s2 must be strings!')
  local t1,t2 = {},{}
  s1:gsub('.',function(c) table.insert(t1,c) end)
  s2:gsub('.',function(c) table.insert(t2,c) end)
  table.sort(t1)
  table.sort(t2)
  return table.concat(t1,'') == table.concat(t2,'')
end

print(friendly_strings('desc','dsec'))
print(friendly_strings('fuck','fcuk'))
print(friendly_strings('poo','eop'))
print(friendly_strings('stripe','sprite'))

