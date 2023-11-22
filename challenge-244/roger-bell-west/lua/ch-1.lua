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

function combinations(arr, k)
   local c = {}
   for i = 1, k do
      table.insert(c, i)
   end
   table.insert(c, #arr + 1)
   table.insert(c, 0)
   local out = {}
   while true do
      local inner = {}
      for i = k, 1, -1 do
         table.insert(inner, arr[c[i]])
      end
      table.insert(out, inner)
      local j = 1
      while c[j] + 1 == c[j + 1] do
         c[j] = j
         j = j + 1
      end
      if j > k then
         break
      end
      c[j] = c[j] + 1
   end
   return ipairs(out)
end

function countsmaller(nums)
   local b = nums
   table.sort(b, function (i,j) return j < i end)
   local sm = {}
   local l = 0
   for i1, e in ipairs(b) do
      local i = i1 - 1
      if i == 0 or e ~= l then
         sm[e] = i
         l = e
      end
   end
   local out = {}
   for _i, n in ipairs(nums) do
      table.insert(out, sm[n])
   end
   return out
end

if recursive_compare(countsmaller({8, 1, 2, 2, 3}), {4, 0, 1, 1, 3}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(countsmaller({6, 5, 4, 8}), {2, 1, 0, 3}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(countsmaller({2, 2, 2}), {0, 0, 0}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

