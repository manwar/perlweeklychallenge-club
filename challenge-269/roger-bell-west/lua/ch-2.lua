#! /usr/bin/lua

function distributeelements(a)
   local x = {a[1]}
   local y = {a[2]}
   for i, n in ipairs(a) do
      if i > 2 then
         if x[#x] > y[#y] then
            table.insert(x, n)
         else
            table.insert(y, n)
         end
      end
   end
   for i, n in ipairs(y) do
      table.insert(x, n)
   end
   return x
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

if recursive_compare(distributeelements({2, 1, 3, 4, 5}), {2, 3, 4, 5, 1}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(distributeelements({3, 2, 4}), {3, 4, 2}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(distributeelements({5, 4, 3, 8}), {5, 3, 4, 8}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

