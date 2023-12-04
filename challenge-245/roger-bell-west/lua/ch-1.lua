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

function sortlanguage(langs, popularities)
   local ix = {}
   for n = 1, #langs do
      table.insert(ix, n)
   end
   table.sort(ix, function (i, j) return popularities[i] < popularities[j] end)
   local out = {}
   for k, v in ipairs(ix) do
      table.insert(out, langs[v])
   end
   return out
end

if recursive_compare(sortlanguage({"perl", "c", "python"}, {2, 1, 3}), {"c", "perl", "python"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(sortlanguage({"c++", "haskell", "java"}, {1, 3, 2}), {"c++", "java", "haskell"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

