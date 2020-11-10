#!/usr/bin/env lua

local t2 = {}

function t2.has_power_expr(n)
  local endpoint = function(x) return 1 + math.floor(math.log(n, x)) end
  for a = 2,endpoint(2) do
    for b = 2,endpoint(a) do
      if n == a ^ b then
        return 1
      end
    end
  end

  return 0
end

function t2.run(args)
  print(t2.has_power_expr(tonumber(args[1])))
end

return t2
