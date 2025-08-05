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

function duplicatezeros(a)
   local b = {}
   for _, n in ipairs(a) do
      table.insert(b, n)
      if #a == #b then
         break
      end
      if n == 0 then
         table.insert(b, 0)
         if #a == #b then
            break
         end
      end
   end
   return b
end

if recursive_compare(duplicatezeros({1, 0, 2, 3, 0, 4, 5, 0}), {1, 0, 0, 2, 3, 0, 0, 4}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(duplicatezeros({1, 2, 3}), {1, 2, 3}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(duplicatezeros({1, 2, 3, 0}), {1, 2, 3, 0}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(duplicatezeros({0, 0, 1, 2}), {0, 0, 0, 0}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(duplicatezeros({1, 2, 0, 3, 4}), {1, 2, 0, 0, 3}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

