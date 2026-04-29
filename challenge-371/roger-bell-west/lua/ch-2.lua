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
   return out
end

function sum(t)
   local ss = 0
   for i, k in ipairs(t) do
      ss = ss + k
   end
   return ss
end

function map(seq, func)
   local out = {}
   for _, x in ipairs(seq) do
      table.insert(out, func(x))
   end
   return out
end

function subsetequilibrium(a)
   local out = {}
   local b = {}
   local ix = {}
   for i, x in ipairs(a) do
      table.insert(b, x - i)
      table.insert(ix, i)
   end
   for n = 1, #b - 1 do
      for _, iy in ipairs(combinations(ix, n)) do
         local bp = sum(map(iy, function(i) return b[i] end))
         if bp == 0 then
            local ap = map(iy, function(i) return a[i] end)
            table.insert(out, ap)
         end
      end
   end
   table.sort(out, function (i, j)
                 local kx = math.min(#i, #j) - 1
                 local k = 1
                 local cmp = i[k] < j[k]
                 while k < kx do
                    if i[k] == j[k] then
                       k = k + 1
                    else
                       cmp = i[k] < j[k]
                       break
                    end
                 end
                 return cmp
   end
   )
   return out
end

if recursive_compare(subsetequilibrium({2, 1, 4, 3}), {{1, 4}, {2, 1}, {2, 3}, {4, 3}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(subsetequilibrium({3, 0, 3, 0}), {{3}, {3, 0}, {3, 0, 3}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(subsetequilibrium({5, 1, 1, 1}), {{5, 1, 1}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(subsetequilibrium({3, -1, 4, 2}), {{3, -1, 4}, {3, 2}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(subsetequilibrium({10, 20, 30, 40}), {}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

