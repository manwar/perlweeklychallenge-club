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

function shortestroute(r0, origin, destination)
   local r = {}
   for _dummy, rt in ipairs(r0) do
      for i = 1, #rt-1 do
         local ri = rt[i]
         local rj = rt[i + 1]
         if r[ri] == nil then
            r[ri] = {}
         end
         r[ri][rj] = true
         if r[rj] == nil then
            r[rj] = {}
         end
         r[rj][ri] = true
      end
   end
   local out = {}
   local stack = { { origin } }
   while #stack > 0 do
      local s = table.remove(stack, 1)
      local l = s[#s]
      if l == destination then
         out = s
         break
      else
         local s1 = {}
         for _dummy, v in ipairs(s) do
            s1[v] = true
            end
         for pd, _dummy in pairs(r[l]) do
            if s1[pd] == nil then
               local q = {}
               for _dummy, v in ipairs(s) do
                  table.insert(q, v)
               end
               table.insert(q, pd)
               table.insert(stack, q)
            end
         end
      end
   end
   return out
end

if recursive_compare(shortestroute({{1, 2, 6}, {5, 6, 7}}, 1, 7), {1, 2, 6, 7}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(shortestroute({{1, 2, 3}, {4, 5, 6}}, 2, 5), {}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(shortestroute({{1, 2, 3}, {4, 5, 6}, {3, 8, 9}, {7, 8}}, 1, 7), {1, 2, 3, 8, 7}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

