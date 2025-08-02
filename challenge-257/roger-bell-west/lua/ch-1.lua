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

function smallerthancurrent(a)
   local s = a
   table.sort(s, function (i, j) return i < j end)
   local l = {}
   for i, n in ipairs(s) do
      if l[n] == nil then
         l[n] = i
      end
   end
   local out = {}
   for _, n in ipairs(a) do
      table.insert(out, l[n])
   end
   return out
end

if recursive_compare(smallerthancurrent({5, 2, 1, 6}), {2, 1, 0, 3}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(smallerthancurrent({1, 2, 0, 3}), {1, 2, 0, 3}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(smallerthancurrent({0, 1}), {0, 1}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(smallerthancurrent({9, 4, 9, 2}), {2, 1, 2, 0}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

