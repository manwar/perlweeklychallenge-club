#!/usr/bin/env lua

local function subsequence(s1,s2)
  assert(type(s1) == 'string' and
	 type(s2) == 'string','s1 and s2 must be strings!')
  local i,j = 1,1
  while i < #s1 and j < #s2 do
    if s1:sub(i,i) == s2:sub(j,j) then i = i + 1 end
    j = j + 1
  end
  return i == #s1
end
    
print(subsequence("uvw","bcudvew"))
print(subsequence("aec","abcde"))
print(subsequence("sip","javascript"))

