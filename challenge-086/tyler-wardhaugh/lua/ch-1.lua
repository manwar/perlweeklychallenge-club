#!/usr/bin/env lua

local t1 = {}

function t1.pair_difference(target, coll)
  local freq = {}
  for _, v in ipairs(coll) do freq[v] = (freq[v] or 0) + 1 end

  for k, v in pairs(freq) do
    if (freq[k + target]) and ((target ~= 0) or (v > 1)) then
      return 1
    end
  end

  return 0
end

function t1.run(args)
  local target = tonumber(args[1])
  table.remove(args, 1)

  local coll = {}
  for _, v in ipairs(args) do table.insert(coll, tonumber(v)) end

  print(t1.pair_difference(target, coll))
end

return t1
