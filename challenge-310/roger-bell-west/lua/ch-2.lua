#! /usr/bin/lua

function sortoddeven(a)
   local odds = {}
   local evens = {}
   for i, x in ipairs(a) do
      if i % 2 == 1 then
         table.insert(evens, x)
      else
         table.insert(odds, x)
      end
   end
   table.sort(evens)
   table.sort(odds,function (aa, bb) return bb < aa end)
   local out = {}
   for i = 2, math.max(#evens, #odds) do
      if i <= #evens then
         table.insert(out, evens[i])
      end
      if i <= #odds then
         table.insert(out, odds[i])
      end
   end
   return out
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

if recursive_compare(sortoddeven({4, 1, 2, 3}), {2, 3, 4, 1}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(sortoddeven({3, 1}), {3, 1}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(sortoddeven({5, 3, 2, 1, 4}), {2, 3, 4, 1, 5}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

