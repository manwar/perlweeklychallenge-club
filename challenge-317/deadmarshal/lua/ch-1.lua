#!/usr/bin/env lua

local function acronyms(t,s)
  assert(type(t) == 'table' and
	 type(s) == 'string',
	 't and s must be a table and a string respectively!')
  local temp = ''
  for i=1,#t do temp = temp .. t[i]:sub(1,1) end
  return temp == s
end

print(acronyms({'Perl','Weekly','Challenge'},'PWC'))
print(acronyms({'Bob','Charlie','Joe'},'BCJ'))
print(acronyms({'Morning','Good'},'MM'))

