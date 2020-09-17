#!/usr/bin/env lua

local t1 = {}

function t1.leaders(a)
  local ldrs = {-1}
  for i=#a, 1, -1 do
    if a[i] > ldrs[1] then
      table.insert(ldrs, 1, a[i])
    end
  end
  table.remove(ldrs, #ldrs)
  return ldrs
end

function t1.run(a)
  local res = table.concat(t1.leaders(a), ', ')
  print('(' .. res .. ')')
end

return t1
