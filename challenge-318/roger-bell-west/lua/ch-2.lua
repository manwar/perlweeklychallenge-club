#! /usr/bin/lua

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
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
  for k, _ in pairs(kk) do
     if (not recursive_compare(t1[k], t2[k])) then
        return false
     end
  end
  return true
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

function reverseequals(a, b)
   if recursive_compare(a, b) then
      return true
   end
   for i = 1, #a - 1 do
      for j = i + 1, #a do
         local c = deepcopy(a)
         for x = i, j do
            c[x] = a[j - (x - i)]
         end
         if recursive_compare(c, b) then
            return true
         end
      end
   end
   return false
end

if reverseequals({3, 2, 1, 4}, {1, 2, 3, 4}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not reverseequals({1, 3, 4}, {4, 1, 3}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if reverseequals({2}, {2}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

