#!/usr/bin/env lua

local function sum_of_frequencies(s)
  assert(type(s) == 'string','s must be a string!')
  local f = {}
  s:lower():gsub(".",function(c) f[c] = (f[c] or 0) + 1 end)
  local v,c = 0,0
  for ch,n in pairs(f) do
    if ch:find("[aeiou]") then v = math.max(v,n)
    else c = math.max(c,n)
    end
  end
  return c + v
end

print(sum_of_frequencies('banana'))
print(sum_of_frequencies('teestett'))
print(sum_of_frequencies('aeiouuaa'))
print(sum_of_frequencies('rhythm'))
print(sum_of_frequencies('x'))

