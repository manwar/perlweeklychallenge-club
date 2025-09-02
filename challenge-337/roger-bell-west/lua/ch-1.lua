#! /usr/bin/lua

function smallerthancurrent(a)
   local b = {}
   for _, x in ipairs(a) do
      table.insert(b, x)
   end
   table.sort(b)
   local m = {}
   for i, v in ipairs(b) do
      if m[v] == nil then
         m[v] = i - 1
      end
   end
   local out = {}
   for _, x in ipairs(a) do
      table.insert(out, m[x])
   end
   return out
end

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

if recursive_compare(smallerthancurrent({6, 5, 4, 8}), {2, 1, 0, 3}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(smallerthancurrent({7, 7, 7, 7}), {0, 0, 0, 0}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(smallerthancurrent({5, 4, 3, 2, 1}), {4, 3, 2, 1, 0}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(smallerthancurrent({-1, 0, 3, -2, 1}), {1, 2, 4, 0, 3}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(smallerthancurrent({0, 1, 1, 2, 0}), {0, 2, 2, 4, 0}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

