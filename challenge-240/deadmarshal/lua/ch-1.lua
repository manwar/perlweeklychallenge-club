#!/usr/bin/env lua

local function acronym(t,check)
  assert(type(t) == 'table' and type(check) == 'string',
	 't,check must be a table and a string respectively!')
  local str_table = {}
  for i=1,#t do table.insert(str_table,t[i]:sub(1,1):lower()) end
  return table.concat(str_table) == check
end

print(acronym({'Perl', 'Python', 'Pascal'},'ppp'))
print(acronym({'Perl', 'Raku'},'rp'))
print(acronym({'Oracle', 'Awk', 'C'},'oac'))

