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

function rangelist(l)
   local o = {}
   local start = l[1]
   local prev = start
   for i, v in ipairs(l) do
      if i > 1 then
         if v ~= prev + 1 then
            if prev > start then
               table.insert(o, {start, prev})
            end
            start = v
         end
         prev = v
      end
   end
   if prev > start then
      table.insert(o, {start, prev})
   end
   return o
end

if recursive_compare(rangelist({1, 3, 4, 5, 7}), {{3, 5}}) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if recursive_compare(rangelist({1, 2, 3, 6, 7, 9}), {{1, 3}, {6, 7}}) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if recursive_compare(rangelist({0, 1, 2, 4, 5, 6, 8, 9}), {{0, 2}, {4, 6}, {8, 9}}) then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
