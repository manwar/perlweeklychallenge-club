#!/usr/bin/env lua

--[[
   An iterator over a table yielding keys (and their corresponding values) in
   sorted order.

   source: ideas from "keysToList" (and others) in:
      http://lua-users.org/wiki/SortedIteration
]]--
function ordered_pairs(tbl, cmp)
  local o = {}
  for k, _ in pairs(tbl) do table.insert(o, k) end
  table.sort(o, cmp)

  local i = 0
  return function()
    i = i + 1
    return o[i], tbl[o[i]]
  end
end

local t2 = {}

do
  local lpeg = require'lpeg'
  lpeg.locale(lpeg)
  local C, Cs, Ct, P, S = lpeg.C, lpeg.Cs, lpeg.Ct, lpeg.P, lpeg.S

  local strip = (S[[."(),]] + P"'s" + P"--" + P"\n")
  t2.sanitizer = Cs((strip / " " + 1)^0)

  local space = lpeg.space^1
  local word = C((1 - space)^1)
  t2.wordify = Ct(word * (space * word)^0)
end

function t2.frequency_sort(text)
  local sanitized = t2.sanitizer:match(text)
  local words = t2.wordify:match(sanitized)

  local count = {}
  for _, v in ipairs(words) do count[v] = (count[v] or 0) + 1 end

  local invert = {}
  for k, v in pairs(count) do
    if invert[v] then
      table.insert(invert[v], k)
    else
      invert[v] = {k}
    end
  end

  for _, v in pairs(invert) do table.sort(v) end

  return invert
end

function t2.slurp(input)
  local fh = assert(io.open(input, "r"))
  local text = fh:read("*all")
  fh:close()
  return text
end

function t2.run(args)
  local input = args[1]
  local results = t2.frequency_sort(t2.slurp(input))
  for k, v in ordered_pairs(results) do
    print(k, table.concat(v, " "), "\n")
  end
end

return t2
