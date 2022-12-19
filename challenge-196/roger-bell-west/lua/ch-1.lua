#! /usr/bin/lua
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

function pattern132(l)
   local o = {}
   for a = 1, #l-2 do
      for b = a+1, #l-1 do
         if l[a] < l[b] then
            for c = b+1, #l do
               if l[b] > l[c] and l[a] < l[c] then
                  o = {l[a], l[b], l[c]}
                  break
               end
            end
         end
         if #o > 0 then
            break
         end
      end
      if #o > 0 then
         break
      end
   end
   return o
end

if recursive_compare(pattern132({3, 1, 4, 2}), {1, 4, 2}) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")
if recursive_compare(pattern132({1, 2, 3, 4}), {}) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")
if recursive_compare(pattern132({1, 3, 2, 4, 6, 5}), {1, 3, 2}) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")
if recursive_compare(pattern132({1, 3, 4, 2}), {1, 3, 2}) then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
