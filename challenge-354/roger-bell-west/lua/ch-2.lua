#! /usr/bin/lua

function windows(a, size, offset)
   local out = {}
   for i = 1, #a - size + 1, offset do
      local w = {}
      for j = 0, size - 1 do
         if i + j <= #a then
            table.insert(w, a[i + j])
         end
      end
      table.insert(out, w)
   end
   return out
end

function shiftgrid(gi, k0)
   local wi = {}
   for _x, a in ipairs(gi) do
      for _y, b in ipairs(a) do
         table.insert(wi, b)
      end
   end
   local k = k0 % #wi
   local wo = {}
   for i = #wi - k + 1, #wi do
      table.insert(wo, wi[i])
      end
   for i = 1, #wi - k do
      table.insert(wo, wi[i])
   end
   return windows(wo, #gi[1], #gi[1])
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

if recursive_compare(shiftgrid({{1, 2, 3}, {4, 5, 6}, {7, 8, 9}}, 1), {{9, 1, 2}, {3, 4, 5}, {6, 7, 8}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(shiftgrid({{10, 20}, {30, 40}}, 1), {{40, 10}, {20, 30}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(shiftgrid({{1, 2}, {3, 4}, {5, 6}}, 1), {{6, 1}, {2, 3}, {4, 5}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(shiftgrid({{1, 2, 3}, {4, 5, 6}}, 5), {{2, 3, 4}, {5, 6, 1}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(shiftgrid({{1, 2, 3, 4}}, 1), {{4, 1, 2, 3}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

