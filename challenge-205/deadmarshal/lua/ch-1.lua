#!/usr/bin/env lua

local function uniq(t)
  assert(type(t) == 'table','t must be a table!')
  local ret,uniqs = {},{}
  for i=1,#t do
    uniqs[t[i]] = 1
  end
  for k,v in pairs(uniqs) do ret[#ret+1] = k end
  return ret
end

local function third_highest(t)
  assert(type(t) == 'table','t must be a table!')
  local uniqs = uniq(t)
  table.sort(uniqs,function(a,b) return a > b end)
  if not uniqs[3] then return uniqs[1] else return uniqs[3] end
end

print(third_highest({5,3,4}))
print(third_highest({5,6}))
print(third_highest({5,4,4,3}))

