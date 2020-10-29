#!/usr/bin/env lua

local t1 = {}

t1.max_integer = 2^31 - 1
t1.min_integer = -2^31

function t1.signum(n)
  if n > 0 then return 1
  elseif n < 0 then return -1
  else return 0
  end
end

function t1.reverse_integer(n)
  local status, int_n = pcall(math.tointeger, n)
  if not status then return 0 end

  local sign = t1.signum(int_n)
  local rev_n = sign * math.tointeger(string.reverse(tostring(math.abs(int_n))))

  if rev_n < t1.min_integer or rev_n > t1.max_integer then
    return 0
  end

  return rev_n
end

function t1.run(args)
  local n = args[1]
  local reversed = t1.reverse_integer(n)
  print(reversed)
end

return t1
