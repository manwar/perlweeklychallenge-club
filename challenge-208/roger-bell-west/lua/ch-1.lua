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

function v2hm(a)
   local h = {}
   for i, x in ipairs(a) do
      if h[x] == nil then
         h[x] = i
      end
   end
   return h
end

function minindexsum(a, b)
   local ah = v2hm(a)
   local bh = v2hm(b)
   local out = {}
   local mi = #a + #b
   for w, av in pairs(ah) do
      if bh[w] ~= nil then
         mv = av + bh[w]
         if mv < mi then
            out = {}
            mi = mv
         end
         if mv == mi then
            table.insert(out, w)
         end
      end
   end
   table.sort(out)
   return out
end

if recursive_compare(minindexsum({"Perl", "Raku", "Love"}, {"Raku", "Perl", "Hate"}), {"Perl", "Raku"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(minindexsum({"A", "B", "C"}, {"D", "E", "F"}), {}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(minindexsum({"A", "B", "C"}, {"C", "A", "B"}), {"A"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

