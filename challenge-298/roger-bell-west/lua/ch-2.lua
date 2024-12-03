#! /usr/bin/lua

function rightinterval(a)
   local ss = {}
   for _, x in ipairs(a) do
      table.insert(ss, x[1])
   end
   local si = {}
   for x = 1, #a do
      table.insert(si, x)
   end
   table.sort(si, function (i, j) return ss[i] < ss[j] end)
   local out = {}
   for _, l in ipairs(a) do
      local ix = -1
      for _, i in ipairs(si) do
         if ss[i] >= l[2] then
            ix = i
            break
         end
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

if recursive_compare(rightinterval({{3, 4}, {2, 3}, {1, 2}}), {-1, 0, 1}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(rightinterval({{1, 4}, {2, 3}, {3, 4}}), {-1, 2, -1}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(rightinterval({{1, 2}}), {-1}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(rightinterval({{1, 4}, {2, 2}, {3, 4}}), {-1, 1, -1}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

