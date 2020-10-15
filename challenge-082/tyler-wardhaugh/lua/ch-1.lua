#!/usr/bin/env lua

local t1 = {}

-- Greatest Common Divisor
-- source: https://www.rosettacode.org/wiki/Greatest_common_divisor#Lua
function t1.gcd(a, b)
    while b ~= 0 do
        a, b = b, a % b
    end
    return math.floor(math.abs(a))
end

function t1.common_factors(m, n)
  local gcd = t1.gcd(m, n)
  local factors = {[1]=true, [gcd]=true}       -- 1 and gcd are always factors

  for i = 2, gcd // 2 do
    if math.fmod(gcd, i) == 0 then
      factors[i] = true
    end
  end

  local results = {}
  for k, _ in pairs(factors) do table.insert(results, k) end
  table.sort(results)
  return results
end

function t1.run(args)
  local m, n = math.floor(tonumber(args[1])), math.floor(tonumber(args[2]))
  if not m or not n then
    io.stderr:write("error: must supply two integers\n")
    os.exit(2)
  end

  local factors = t1.common_factors(m, n)
  print(table.concat(factors, " "))
end

return t1
