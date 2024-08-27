#! /usr/bin/lua

function relativesort(list1, list2)
   local c = {}
   for _, n in ipairs(list1) do
      if c[n] == nil then
         c[n] = 1
      else
         c[n] = c[n] + 1
      end
   end
   local out = {}
   for _, i in ipairs(list2) do
      if c[i] ~= nil then
         for j = 1, c[i] do
            table.insert(out, i)
         end
      end
   end
   local d ={}
   for k, _ in pairs(c) do
      table.insert(d, k)
   end
   table.sort(d, function (i, j) return i > j end)
   for _, i in ipairs(d) do
      for j = 1, c[i] do
         table.insert(out, i)
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

if recursive_compare(relativesort({2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5}, {2, 1, 4, 3, 5, 6}), {2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(relativesort({3, 3, 4, 6, 2, 4, 2, 1, 3}, {1, 3, 2}), {1, 3, 3, 3, 2, 2, 4, 4, 6}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(relativesort({3, 0, 5, 0, 2, 1, 4, 1, 1}, {1, 0, 3, 2}), {1, 1, 1, 0, 0, 3, 2, 4, 5}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

