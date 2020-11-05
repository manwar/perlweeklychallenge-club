#!/usr/bin/env lua

local t1 = {}

function t1.find_triplet_sum(coll)
  local tbl = {}
  for _, v in ipairs(coll) do
    if v < 2 then table.insert(tbl, v) end
  end

  table.sort(tbl)

  local sum
  for i = 1,#tbl - 2 do
    sum = tbl[i] + tbl[i+1] + tbl[i+2]
    if sum > 1 and sum < 2 then
      return 1
    end
  end

  return 0
end

function t1.run(args)
  local coll = {}
  for _, v in ipairs(args) do table.insert(coll, tonumber(v)) end
  print(t1.find_triplet_sum(coll))
end

return t1
