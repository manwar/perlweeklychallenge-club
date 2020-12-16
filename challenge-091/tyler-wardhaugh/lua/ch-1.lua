#!/usr/bin/env lua

local t1 = {}
t1.DEFAULT_INPUT = 1122234

function t1.count_numbers(n)
  --[[
        Lua's standard pattern matching does not support back-references, so
        we need to do some trickery.

        Idea from:
          https://stackoverflow.com/questions/48541679/lua-pattern-matching-series-of-same-character
  ]]--
  local result = (tostring(n) .. '\0')
      :gsub('%d', '\0%0%0')
      :gsub('(.)%z%1', '%1')
      :gsub('%d+%z', function(run) return run:len() - 2 .. run:sub(1, 1) end)
  return tonumber(result:sub(2))
end

function t1.run(args)
  local n = args[1] or t1.DEFAULT_INPUT
  print(t1.count_numbers(n))
end

return t1
