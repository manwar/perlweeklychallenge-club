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

function movezero(l)
   local o = {}
   local z = 0
   for i, v in ipairs(l) do
      if v == 0 then
         z = z + 1
      else
         table.insert(o, v)
      end
   end
   for i = 1, z do
      table.insert(o, 0)
   end
   return o
end

if recursive_compare(movezero({1, 0, 3, 0, 0, 5}), {1, 3, 5, 0, 0, 0}) then
   io.write("Pass")
else
   io.write("FAIL")
end
if recursive_compare(movezero({1, 6, 4}), {1, 6, 4}) then
io.write(" ")
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")
if recursive_compare(movezero({0, 1, 0, 2, 0}), {1, 2, 0, 0, 0}) then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
