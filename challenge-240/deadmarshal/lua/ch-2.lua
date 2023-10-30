#!/usr/bin/env lua

local function build_array(t)
  assert(type(t) == 'table','t must be a table!')
  local ret = {}
  for i=1,#t do ret[i] = t[t[i]+1] end
  return ret
end

print(table.unpack(build_array{0,2,1,5,3,4}))
print(table.unpack(build_array{5,0,1,2,3,4}))

