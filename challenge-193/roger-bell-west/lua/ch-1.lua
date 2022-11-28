#! /usr/bin/lua

function recursive_compare(t1,t2)
   -- Use usual comparison first.
   if t1==t2 then return true end
   -- We only support non-default behavior for tables
   if (type(t1)~="table") then return false end
   -- They better have the same metatables
   local mt1 = getmetatable(t1)
   local mt2 = getmetatable(t2)
   if( not recursive_compare(mt1,mt2) ) then return false end

   -- Check each key-value pair
   -- We have to do this both ways in case we miss some.
   -- TODO: Could probably be smarter and not check those we've 
   -- already checked though!
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

function tobase(val0, len, base)
   local s = ""
   local val = val0
   for i = 1, len do
      s = tostring(val % base) .. s
      val = val // base
   end
   return s
end

function binarystring(n)
   local o = {}
   for a = 0,(1 << n)-1 do
      table.insert(o,tobase(a, n, 2))
   end
   return o
end

if recursive_compare(binarystring(2), {"00", "01", "10", "11"}) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if recursive_compare(binarystring(3), {"000", "001", "010", "011", "100", "101", "110", "111"}) then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
