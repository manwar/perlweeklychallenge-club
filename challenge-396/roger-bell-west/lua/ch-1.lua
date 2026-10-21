#! /usr/bin/lua

function filter(seq, func)
   local out = {}
   for _, x in ipairs(seq) do
      if func(x) then
         table.insert(out, x)
      end
   end
   return out
end

function toset(a)
   local cc = {}
   for _, c in ipairs(a) do
      cc[c] = true
   end
   return cc
end

function finishingorder(order, friends)
   local wanted = toset(friends)
   return filter(order, function(x) return wanted[x] ~= nil end)
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

if recursive_compare(finishingorder({3, 1, 4, 2, 5}, {1, 4, 2}), {1, 4, 2}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(finishingorder({5, 4, 3, 2, 1}, {1, 3, 5}), {5, 3, 1}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(finishingorder({2, 4, 1, 3}, {1, 2, 3, 4}), {2, 4, 1, 3}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(finishingorder({4, 1, 3, 2}, {3}), {3}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(finishingorder({1, 3, 2, 6, 5, 4}, {1, 2, 3}), {1, 3, 2}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

