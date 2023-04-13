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

function propersize(t)
   local l=0
   for k,v in pairs(t) do
      l = l + 1
   end
   return l
end

function rearrangegroups(list, size)
   local h = {}
   for i, k in ipairs(list) do
      if h[k] == nil then
         t = 1
      else
         t = h[k] + 1
      end
      h[k] = t
   end
   local out = {}
   while true do
      local m = nil
      for k, v in pairs(h) do
         if m == nil then
            m = k
         else
            m = math.min(m, k)
         end
      end
      local res = {}
      for i = m, m + size - 1 do
         table.insert(res, i)
      end
      for i, n in ipairs(res) do
         if h[n] == nil then
            return {}
         else
            local p = h[n] - 1
            if p == 0 then
               h[n] = nil
            else
               h[n] = p
            end
         end
      end
      table.insert(out, res)
      if propersize(h) == 0 then
         break
      end
   end
   return out
end

if recursive_compare(rearrangegroups({1, 2, 3, 5, 1, 2, 7, 6, 3}, 3), {{1, 2, 3}, {1, 2, 3}, {5, 6, 7}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(rearrangegroups({1, 2, 3}, 2), {}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(rearrangegroups({1, 2, 4, 3, 5, 3}, 3), {{1, 2, 3}, {3, 4, 5}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(rearrangegroups({1, 5, 2, 6, 4, 7}, 3), {}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

