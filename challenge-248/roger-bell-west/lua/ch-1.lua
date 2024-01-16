#! /usr/bin/lua

-- by Michael Anderson at
-- https://stackoverflow.com/questions/8722620/comparing-two-index-tables-by-index-value-in-lua
-- modified by Roger
function recursive_compare(t1,t2)
  -- Use usual comparison first.
  if t1==t2 then return true end
  -- We only support non-default behavior for tables
  if (type(t1)~="table") then return false end
  -- They better have the same metatables
  local mt1 = getmetatable(t1)
  local mt2 = getmetatable(t2)
  if( not recursive_compare(mt1,mt2) ) then return false end
  -- Build list of all keys
  local kk = {}
  for k1, _ in pairs(t1) do
     kk[k1] = true
  end
  for k2, _ in pairs(t2) do
     kk[k2] = true
  end
  -- Check each key that exists in at least one table
  for _, k in ipairs(kk) do
     if (not recursive_compare(t1[k], t2[k])) then
        return false
     end
  end
  return true
end

function shortestdistance(a, c)
   local q = {}
   local i = 1
   while i >= 1 do
      local p = string.find(a, c, i, true)
      if p then
         table.insert(q, {p, 0})
         i = p + 1
      else
         i = 0
      end
   end
   local invalid = #a + 1
   local out = {}
   for i = 1, #a do
      out[i] = invalid
   end
   while (#q > 0) do
      local i, v = table.remove(q, 1)
      if out[i] == invalid then
         out[i] = v
         if i > 1 then
            table.insert(q, {i - 1, v + 1})
         end
         if i < #a then
            table.insert(q, {i + 1, v + 1})
         end
      end
   end
   return out
end

if recursive_compare(shortestdistance("loveleetcode", "e"), {3, 2, 1, 0, 1, 0, 0, 1, 2, 2, 1, 0}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(shortestdistance("aaab", "b"), {3, 2, 1, 0}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

