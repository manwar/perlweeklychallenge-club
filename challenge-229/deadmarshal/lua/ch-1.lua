#!/usr/bin/env lua

local function lexicographic_order(t)
  assert(type(t) == "table", "t must be a table!")
  local count = 0
  local function sorted_str(s)
    local t = {}
    s:gsub(".",function(c) table.insert(t,c) end)
    table.sort(t)
    return table.concat(t,'')
  end
  for i=1,#t do
    local s = sorted_str(t[i])
    if s ~= t[i] and s:reverse() ~= t[i] then count = count + 1 end
  end
  return count
end

print(lexicographic_order({"abc", "bce", "cae"}))
print(lexicographic_order({"yxz", "cba", "mon"}))

