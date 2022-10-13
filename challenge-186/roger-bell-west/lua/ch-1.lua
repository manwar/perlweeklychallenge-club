#! /usr/bin/lua

-- by Michael Anderson at
-- https://stackoverflow.com/questions/8722620/comparing-two-index-tables-by-index-value-in-lua
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

function zip(a, b)
   local out = {}
   for i = 1,#a do
      table.insert(out,a[i])
      table.insert(out,b[i])
   end
   return out
end

if recursive_compare(zip({1, 2, 3}, {"a", "b", "c"}), {1, "a", 2, "b", 3, "c"}) then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
