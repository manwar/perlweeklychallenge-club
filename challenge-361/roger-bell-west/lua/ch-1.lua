#! /usr/bin/lua

function zeckendorfrepresentation(a)
   local fib = {0, 1}
   while fib[#fib] <= a do
      table.insert(fib, fib[#fib] + fib[#fib-1])
   end
   table.remove(fib)
   local res = {}
   local aw = a
   while aw > 0 do
      table.insert(res, fib[#fib])
      aw = aw - fib[#fib]
      table.remove(fib)
      table.remove(fib)
      while fib[#fib] > aw do
         table.remove(fib)
      end
   end
   return res
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

if recursive_compare(zeckendorfrepresentation(4), {3, 1}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(zeckendorfrepresentation(12), {8, 3, 1}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(zeckendorfrepresentation(20), {13, 5, 2}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(zeckendorfrepresentation(96), {89, 5, 2}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(zeckendorfrepresentation(100), {89, 8, 3}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

