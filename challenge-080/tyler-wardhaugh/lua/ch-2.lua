#!/usr/bin/env lua

local t2 = {}

function t2.count_candies(coll)
  local count = #coll

  for i=1,#coll-1 do
    if (coll[i] ~= coll[i+1]) then count = count + 1 end
  end

  return count
end

function t2.run(arg)
  local N = {}
  for _, v in ipairs(arg) do table.insert(N, tonumber(v)) end
  print(t2.count_candies(N))
end

return t2
