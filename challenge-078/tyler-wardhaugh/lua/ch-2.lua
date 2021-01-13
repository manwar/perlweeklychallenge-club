#!/usr/bin/env lua

local t2 = {}

function t2.multi_rotate(list, rotations)
  local rts = {}
  for _, rv in ipairs(rotations) do
    local rotated = table.move(list, rv + 1, #list, 1, {})
    for i = 1, rv do table.insert(rotated, list[i]) end
    table.insert(rts, rotated)
  end
  return rts
end

function t2.run(...)
  local res = t2.multi_rotate(...)
  for _, v in ipairs(res) do
    print('[' .. table.concat(v, ' ') .. ']')
  end
end

return t2
