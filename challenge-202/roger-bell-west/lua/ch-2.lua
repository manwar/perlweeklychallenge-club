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

function widestvalley(a)
   local av = {}
   local ac = {}
   local l = -1
   for i,v in ipairs(a) do
      if v == l then
         ac[#ac] = ac[#ac] + 1
      else
         table.insert(av, v)
         table.insert(ac, 1)
         l = v
      end
   end
   local s = {}
   local e = {}
   local c = 1
   for i,v in ipairs(av) do
      local peak = false
      if i == 1 or i == #av then
         peak = true
      end
      if not peak then
         if (av[i - 1] < v and v > av[i + 1]) then
            peak = true
         end
      end
      if peak then
         table.insert(s, c)
         table.insert(e, c + ac[i] - 1)
      end
      c = c + ac[i]
   end
   local out = {}
   for i,v in ipairs(s) do
      if i == #s then
         break
      end
      if e[i + 1] - s[i] + 1 > #out then
         out = {}
         for j = s[i], e[i+1] do
            table.insert(out, a[j])
         end
      end
   end
   return out
end

if recursive_compare(widestvalley({1, 5, 5, 2, 8}), {5, 5, 2, 8}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(widestvalley({2, 6, 8, 5}), {2, 6, 8}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(widestvalley({9, 8, 13, 13, 2, 2, 15, 17}), {13, 13, 2, 2, 15, 17}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(widestvalley({2, 1, 2, 1, 3}), {2, 1, 2}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(widestvalley({1, 3, 3, 2, 1, 2, 3, 3, 2}), {3, 3, 2, 1, 2, 3, 3}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

