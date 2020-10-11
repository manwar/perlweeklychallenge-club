#!/usr/bin/env lua

local t1 = {}

do
  local lpeg = require'lpeg'
  local P = lpeg.P
  function t1.make_pat(s)
    return P(s)
  end
end

function t1.common_base_string(s1, s2)
  -- ensure s1 is smaller or equal in length to s2
  if s1:len() > s2:len() then
    s1, s2 = s2, s1
  end

  local s2_len = s2:len()
  local results, substring, part = {}
  for i = 1,s2_len do
    -- skip attempt if s2's length not evenly divisible by i
    if s2_len % i ~= 0 then goto continue end

    substring = s2:sub(1, s2_len // i)
    part = t1.make_pat(substring)
    if (part^i):match(s2) and (part^1 * -1):match(s1) then
      table.insert(results, substring)
    end
    ::continue::
  end

  return results
end

function t1.run(args)
  local S1, S2 = table.unpack(args, 1, 2)
  local bases = t1.common_base_string(S1, S2)
  print(table.concat(bases, " "))
end

return t1
