#!/usr/bin/env lua

local t1 = {}

function t1.find_triplet_sum(coll)
  local lower = 1
  local upper = 2
  local num_elems = 3

  -- filter out any value more than the upper bound and limit repeated values
  -- to the number of elements we sum (3)
  local seen = {}
  local tbl = {}
  for _, v in ipairs(coll) do
    seen[v] = 1 + (seen[v] or 0)
    if (v < upper) and (seen[v] <= num_elems) then table.insert(tbl, v) end
  end

  local sum
  for i = 1,#tbl - 2 do
    for j = i+1,#tbl - 1 do
      for k = j+1,#tbl do
        sum = tbl[i] + tbl[j] + tbl[k]
        if (lower < sum) and (sum < upper) then
          return 1
        end
      end
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
