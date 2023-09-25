#!/usr/bin/env lua

local function duplicate_zeros(t)
  assert(type(t) == 'table','t must be a table!')
  local ret = {}
  for i=1,#t do
    if #ret == #t then break end
    if t[i] == 0 then
      table.insert(ret,0)
      table.insert(ret,0)
    else
      table.insert(ret,t[i])
    end
  end
  return table.concat(ret,',')
end

print(duplicate_zeros({1,0,2,3,0,4,5,0}))
print(duplicate_zeros({1,2,3}))
print(duplicate_zeros({0,3,0,4,5}))

