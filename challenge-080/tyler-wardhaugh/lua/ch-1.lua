#!/usr/bin/env lua

local t1 = {}

function t1.smallest_missing(coll)
  local range = {0}
  for _, v in ipairs(coll) do
    if v > 0 then table.insert(range, v) end
  end
  table.sort(range)

  local next, cur
  for i=1,#range do
    cur = range[i]
    next = range[i+1]

    if next and ((next - cur) > 1) then
      return cur + 1
    end
  end

  -- there are no gaps, therefore the smallest "missing" positive integer is
  -- the maximum number given (i.e., the last one in the sorted table) plus one
  return range[#range] + 1
end

function t1.run(arg)
  local N = {}
  for _, v in ipairs(arg) do table.insert(N, tonumber(v)) end
  print(t1.smallest_missing(N))
end

return t1
