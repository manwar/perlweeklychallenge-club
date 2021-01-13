#!/usr/bin/env lua

local t2 = {}
t2.DEFAULT_INPUT = {1, 2, 1, 2}

function t2.jump_game(coll)
  local i,j = 1
  while true do
    if i == #coll then return true end

    j = i + coll[i]
    if i == j or j > #coll then
      return false
    end

    i = j
  end
end

function t2.run(args)
  local coll
  if #args > 0 then
    coll = {}
    for _, v in ipairs(args) do
      table.insert(coll, tonumber(v))
    end
  else
    coll = t2.DEFAULT_INPUT
  end

  local result = t2.jump_game(coll)
  if result then print(1) else print(0) end
end

return t2
