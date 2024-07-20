#!/usr/bin/env lua

local function sort_by(t,f)
  assert(type(t) == 'table','t must be a table!')
  local keys = {}
  for k in pairs(t) do keys[#keys+1] = k end
  table.sort(keys,function(a,b) return f(t[a],t[b]) end)
  return keys
end

local function sort_string(s)
  assert(type(s) == 'string','s must be a string!')
  local t = {}
  for w in s:gmatch('%S+') do
    for k,v in w:gmatch('(%a+)(%d+)') do t[k] = v end
  end
  return table.concat(sort_by(t,function(a,b) return a < b end),' ')
end

print(sort_string'and2 Raku3 cousins5 Perl1 are4')
print(sort_string'guest6 Python1 most4 the3 popular5 is2 language7')
print(sort_string'Challenge3 The1 Weekly2')
