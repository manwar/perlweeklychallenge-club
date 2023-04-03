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

function numbercollision(aa)
   local a = aa
   local dirty = true
   while dirty do
      local b = {}
      dirty = false
      local i = 1
      while i <= #a do
         if i < #a and a[i] > 0 and a[i + 1] < 0 then
            local ab = math.abs(a[i + 1])
            if a[i] > ab then
               table.insert(b, a[i])
            elseif a[i] < ab then
               table.insert(b, a[i + 1])
            end
            i = i + 2
            dirty = true
         else
            table.insert(b, a[i])
            i = i + 1
         end
      end
      a = b
   end
   return a
end

if recursive_compare(numbercollision({2, 3, -1}), {2, 3}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(numbercollision({3, 2, -4}), {-4}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(numbercollision({1, -1}), {}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

