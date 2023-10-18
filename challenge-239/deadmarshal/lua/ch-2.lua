#!/usr/bin/env lua

local function consistent_strings(t,allowed)
  assert(type(t) == 'table' and type(allowed) == 'string',
	 't,allowed must be a table and string respectively!')
  local count = 0
  for i=1,#t do
    local temp = true
    for j=1,#t[i] do
      if not allowed:match(t[i]:sub(j,j)) then temp = false break end
    end
    if temp == true then count = count + 1 end
  end
  return count
end

print(consistent_strings({'ad','bd','aaab','baa','badab'},'ab'))
print(consistent_strings({'a','b','c','ab','ac','bc','abc'},'aabc'))
print(consistent_strings({'cc','acd','b','ba','bac','bad','ac','d'},
	'cad'))

