#! /usr/bin/lua

-- by Michael Anderson at
-- https://stackoverflow.com/questions/8722620/comparing-two-index-tables-by-index-value-in-lua
function recursive_compare(t1,t2)
   if t1==t2 then return true end
   if (type(t1)~="table") then return false end
   local mt1 = getmetatable(t1)
   local mt2 = getmetatable(t2)
   if( not recursive_compare(mt1,mt2) ) then return false end
   for k1,v1 in pairs(t1) do
      local v2 = t2[k1]
      if( not recursive_compare(v1,v2) ) then return false end
   end
   for k2,v2 in pairs(t2) do
      local v1 = t1[k2]
      if( not recursive_compare(v1,v2) ) then return false end
   end
   return true
end

function funsort(l0)
   local l = l0
   table.sort(l)
   local a = {}
   local b = {}
   for i, k in ipairs(l) do
      if k % 2 == 0 then
         table.insert(a, k)
      else
         table.insert(b, k)
      end
   end
   for i, k in ipairs(b) do
      table.insert(a, k)
   end
   return a
end

if recursive_compare(funsort({1, 2, 3, 4, 5, 6}), {2, 4, 6, 1, 3, 5}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(funsort({1, 2}), {2, 1}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(funsort({1}), {1}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

