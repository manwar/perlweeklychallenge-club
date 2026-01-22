#! /usr/bin/lua

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

function gcd(m0,n0)
   local m,n = m0,n0
   while n ~= 0 do
      m,n = n,m % n
   end
   return m
end

function keys(t)
   local a = {}
   for k, v in pairs(t) do
      table.insert(a, k)
   end
   return a
end

function uniquefractiongenerator(a)
   local den = 1
   for dn = 2, a do
      den = den * dn
   end
   local f = {}
   for d = 1, a do
      local nd = den // d
      for n = 1, a do
         f[n * nd] = true
      end
   end
   local ff = keys(f)
   table.sort(ff)
   local out = {}
   for _, n in ipairs(ff) do
      local g = gcd(n, den)
      local nn = n // g
      local nd = den // g
      table.insert(out, tostring(nn) .. "/" .. tostring(nd))
   end
   return out
end

if recursive_compare(uniquefractiongenerator(3), {"1/3", "1/2", "2/3", "1/1", "3/2", "2/1", "3/1"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(uniquefractiongenerator(4), {"1/4", "1/3", "1/2", "2/3", "3/4", "1/1", "4/3", "3/2", "2/1", "3/1", "4/1"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(uniquefractiongenerator(1), {"1/1"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(uniquefractiongenerator(6), {"1/6", "1/5", "1/4", "1/3", "2/5", "1/2", "3/5", "2/3", "3/4", "4/5", "5/6", "1/1", "6/5", "5/4", "4/3", "3/2", "5/3", "2/1", "5/2", "3/1", "4/1", "5/1", "6/1"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(uniquefractiongenerator(5), {"1/5", "1/4", "1/3", "2/5", "1/2", "3/5", "2/3", "3/4", "4/5", "1/1", "5/4", "4/3", "3/2", "5/3", "2/1", "5/2", "3/1", "4/1", "5/1"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

