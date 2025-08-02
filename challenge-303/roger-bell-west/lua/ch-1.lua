#! /usr/bin/lua

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

function permute(a)
   local out = {}
   local n = #a
   local c = {}
   for i = 1,n do
      table.insert(c, 1)
   end
   table.insert(out, deepcopy(a))
   local i=1
   while true do
      if i > n then
         break
      end
      if c[i] < i then
         if i % 2 == 1 then
            a[1],a[i] = a[i],a[1]
         else
            a[c[i]],a[i] = a[i],a[c[i]]
         end
         table.insert(out, deepcopy(a))
         c[i] = c[i]+1
         i = 1
      else
        c[i] = 1
         i = i+1
      end
   end
   return out
end

function keys(t)
   local a = {}
   for k, v in pairs(t) do
      table.insert(a, k)
   end
   return a
end

function concatenate(a)
   local st = ""
   for _, x in ipairs(a) do
      st = st .. x
   end
   return 0 + st
end

function threedigitseven(a)
   local s = {}
   for mask = 1, (1 << #a) - 1 do
      local pl = {}
      for i, x in ipairs(a) do
         if (mask & (1 << (i - 1))) > 0 then
            table.insert(pl, x)
         end
      end
      for _, px in ipairs(permute(pl)) do
         local c = concatenate(px)
         if c >= 100 and c <= 999 and c % 2 == 0 then
            s[c] = true
         end
      end
   end
   local o = keys(s)
   table.sort(o)
   return o
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

if recursive_compare(threedigitseven({2, 1, 3, 0}), {102, 120, 130, 132, 210, 230, 302, 310, 312, 320}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(threedigitseven({2, 2, 8, 8, 2}), {222, 228, 282, 288, 822, 828, 882}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

