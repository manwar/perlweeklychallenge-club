#!/usr/bin/env lua

local t2 = {}

function t2.count_candies(coll)
  local count = #coll
  local maybe_inc = function(i, j)
    if (coll[i] > coll[j]) then count = count + 1 end
  end

  -- sweep left-to-right
  for i=1,#coll-1 do maybe_inc(i, i+1) end
  -- sweep right-to-left
  for i=#coll,2,-1 do maybe_inc(i, i-1) end

  return count
end

function t2.run(arg)
  local N = {}
  for _, v in ipairs(arg) do table.insert(N, tonumber(v)) end
  print(t2.count_candies(N))
end

return t2
