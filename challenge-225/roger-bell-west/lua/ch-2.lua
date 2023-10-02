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

function leftrightsumdiff(a)
   local al = #a
   local left = {0}
   local right = {0}
   for i = 1, al - 1 do
      table.insert(left, left[i] + a[i])
      table.insert(right, 1, right[1] + a[al - i + 1])
   end
   local out = {}
   for i = 1, al do
      table.insert(out, math.abs(left[i] - right[i]))
   end
   return out
end


if recursive_compare(leftrightsumdiff({10, 4, 8, 3}), {15, 1, 11, 22}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(leftrightsumdiff({1}), {0}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(leftrightsumdiff({1, 2, 3, 4, 5}), {14, 11, 6, 1, 10}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

