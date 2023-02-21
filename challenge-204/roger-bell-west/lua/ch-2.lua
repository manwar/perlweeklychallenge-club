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

function reshapematrix(m, r, c)
   local mv = {}
   for i1, rv in ipairs(m) do
      for i2, cv in ipairs(rv) do
         table.insert(mv, cv)
      end
   end
   if r * c ~= #mv then
      return {{0}}
   end
   local out = {}
   for i = 0, r - 1 do
      local rv = {}
      for x = i * c + 1, (i + 1) * c do
         table.insert(rv, mv[x])
      end
      table.insert(out, rv)
   end
   return out
end

if recursive_compare(reshapematrix({{1, 2}, {3, 4}}, 1, 4), {{1, 2, 3, 4}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(reshapematrix({{1, 2, 3}, {4, 5, 6}}, 3, 2), {{1, 2}, {3, 4}, {5, 6}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(reshapematrix({{1, 2}}, 3, 2), {{0}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

