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

function persistence(a)
   local steps = 0
   local b = a
   while b > 9 do
      steps = steps + 1
      local p = 1
      while b > 0 do
         p = p * (b % 10)
         b = b // 10
      end
      b = p
   end
   return steps
end

function persistencearray(a)
   local b = a
   local c = {}
   for _, v in ipairs(b) do
      if c[v] == nil then
         c[v] = persistence(v)
      end
   end
   table.sort(b, function(a, b)
                 if c[a] == c[b] then
                    return a < b
                 else
                    return c[a] < c[b]
                 end
   end)
   return b
end

if recursive_compare(persistencearray({15, 99, 1, 34}), {1, 15, 34, 99}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(persistencearray({50, 25, 33, 22}), {22, 33, 50, 25}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

