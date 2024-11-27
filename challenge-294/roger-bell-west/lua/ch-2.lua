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
function permute(a)
   local out = {}
   local n = #a
   local c = {}
   for i = 1,n do
      table.insert(c, 1)
   end
   table.insert(out, deepcopy(a))
   local i=1
   while true do
      if i > n then
         break
      end
      if c[i] < i then
         if i % 2 == 1 then
            a[1],a[i] = a[i],a[1]
         else
            a[c[i]],a[i] = a[i],a[c[i]]
         end
         table.insert(out, deepcopy(a))
         c[i] = c[i]+1
         i = 1
      else
        c[i] = 1
         i = i+1
      end
   end
   return out
end
function deepcopy(src)
   local dst = {}
   for k, v in pairs(src) do
      if type(v) == "table" then
         v = deepcopy(v)
      end
      dst[k] = v
   end
   return dst
end

function listcmp(a, b)
   local ix = 1
   while true do
      if ix > #a and ix > #b then
         return false
      end
      if ix <= #a and ix > #b then
         return true
      end
      if ix > #a and ix <= #b then
         return false
      end
      if a[ix] ~= b[ix] then
         return a[ix] < b[ix]
      end
      ix = ix + 1
   end
end

function nextpermutation(a)
   local b = deepcopy(a)
   table.sort(b)
   local flag = false
   local out = {}
   local pp = permute(b)
   table.sort(pp, listcmp)
   for _, px in ipairs(pp) do
      if #out == 0 then
         out = px
      end
      if flag then
         out = px
      end
      if recursive_compare(px, a) then
         flag = true
      end
   end
   return out
end

if recursive_compare(nextpermutation({1, 2, 3}), {1, 3, 2}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(nextpermutation({2, 1, 3}), {2, 3, 1}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(nextpermutation({3, 1, 2}), {3, 2, 1}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

