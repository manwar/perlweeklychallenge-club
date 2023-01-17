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

function arithmeticslices(l)
   local o = {}
   if #l >= 3 then
      for a = 1, #l - 2 do
         local valid = false
         for b = a + 2, #l do
            local v = {table.unpack(l, a, b)}
            if not valid then
               for i = 1, #v - 2 do
                  if v[i + 1] - v[i] == v[i + 2] - v[i + 1] then
                     valid = true
                     break
                  end
               end
            end
            if valid then
               table.insert(o, v)
            end
         end
      end
   end
   return o
end

if recursive_compare(arithmeticslices({1, 2, 3, 4}), {{1, 2, 3}, {1, 2, 3, 4}, {2, 3, 4}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(arithmeticslices({2}), {}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

