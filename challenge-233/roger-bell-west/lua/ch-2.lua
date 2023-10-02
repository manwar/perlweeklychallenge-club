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

function keys(t)
   local a = {}
   for k, v in pairs(t) do
      table.insert(a, k)
   end
   return a
end

function frequencysort(a)
   local ct = {}
   for _, x in ipairs(a) do
      if ct[x] == nil then
         ct[x] = 1
      else
         ct[x] = ct[x] + 1
      end
   end
   local rct = {}
   for k, v in pairs(ct) do
      if rct[v] == nil then
         rct[v] = {}
      end
      table.insert(rct[v], k)
   end
   local out = {}
   local rctk = keys(rct)
   table.sort(rctk)
   for _i, k in ipairs(rctk) do
      local vv = rct[k]
      table.sort(vv, function (aa, bb) return bb < aa end)
      for _j, v in ipairs(vv) do
         for _k = 1, k do
            table.insert(out, v)
         end
      end
   end
   return out
end

if recursive_compare(frequencysort({1, 1, 2, 2, 2, 3}), {3, 1, 1, 2, 2, 2}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(frequencysort({2, 3, 1, 3, 2}), {1, 3, 3, 2, 2}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(frequencysort({-1, 1, -6, 4, 5, -6, 1, 4, 1}), {5, -1, 4, 4, -6, -6, 1, 1, 1}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

