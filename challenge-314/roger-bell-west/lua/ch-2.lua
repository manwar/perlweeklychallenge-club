#! /usr/bin/lua

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

function split(t)
   local cl = {}
   string.gsub(t,
               "(.)",
               function(c)
                  table.insert(cl, c)
               end
   )
   return cl
end

function deepcopy(src)
   local dst = {}
   for k, v in pairs(src) do
      if type(v) == "table" then
         v = deepcopy(v)
      end
      dst[k] = v
   end
   return dst
end

-- by Michael Anderson at
-- https://stackoverflow.com/questions/8722620/comparing-two-index-tables-by-index-value-in-lua
-- modified by Roger
function recursive_compare(t1,t2)
   -- Use usual comparison first.
   if t1==t2 then return true end
   -- We only support non-default behavior for tables
   if (type(t1)~="table") then return false end
   -- They better have the same metatables
   local mt1 = getmetatable(t1)
   local mt2 = getmetatable(t2)
   if( not recursive_compare(mt1,mt2) ) then return false end
   -- Build list of all keys
   local kk = {}
   for k1, _ in pairs(t1) do
      kk[k1] = true
   end
   for k2, _ in pairs(t2) do
      kk[k2] = true
   end
   -- Check each key that exists in at least one table
   for _, k in ipairs(kk) do
      if (not recursive_compare(t1[k], t2[k])) then
         return false
      end
   end
   return true
end

function sortcolumn(a)
   local vv = {}
   for i, s in ipairs(a) do
      for j, c in ipairs(split(s)) do
         if i == 1 then
            table.insert(vv, {})
         end
         table.insert(vv[j], c)
      end
   end
   local tot = 0
   for _, x in ipairs(vv) do
      local y = deepcopy(x)
      table.sort(y)
      for i, xx in ipairs(x) do
         if xx ~= y[i] then
            tot = tot + 1
            break
         end
      end
   end
   return tot
end

if sortcolumn({"swpc", "tyad", "azbe"}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if sortcolumn({"cba", "daf", "ghi"}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if sortcolumn({"a", "b", "c"}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

