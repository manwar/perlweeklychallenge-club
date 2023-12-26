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

function distringmatch(a)
   local v = 1 << (#a - 1)
   local wv = v << 1
   local out = {wv}
   local r = {wv}
   for c in string.gmatch(a, ".") do
      if c == "I" then
         wv = wv + v
      else
         wv = wv - v
      end
      v = v >> 1
      table.insert(out, wv)
      table.insert(r, wv)
   end
   table.sort(r)
   local c = {}
   for i = 1, #r do
      c[r[i]] = i
   end
   local o = {}
   for _, n in ipairs(out) do
      table.insert(o, c[n])
   end
   return o
end

if recursive_compare(distringmatch("IDID"), {0, 4, 1, 3, 2}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(distringmatch("III"), {0, 1, 2, 3}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(distringmatch("DDI"), {3, 2, 0, 1}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

