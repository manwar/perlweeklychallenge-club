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

function duplicateandmissing(a)
   local flags = 0
   local dup = 0
   local mis = 0
   local exp = a[1]
   for i, n in ipairs(a) do
      if n < exp then
         dup = n
         flags = flags | 1
      elseif n > exp then
         mis = exp
         flags = flags | 2
      end
      if flags == 3 then
         return {dup, mis}
      end
      exp = n + 1
   end
   if flags == 1 then
      return {dup, exp}
   end
   return {-1}
end

if recursive_compare(duplicateandmissing({1, 2, 2, 4}), {2, 3}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(duplicateandmissing({1, 2, 3, 4}), {-1}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(duplicateandmissing({1, 2, 3, 3}), {3, 4}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

