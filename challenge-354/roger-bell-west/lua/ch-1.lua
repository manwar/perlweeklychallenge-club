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

function minabsdiff(a)
   local b = a
   table.sort(b)
   local out = {}
   local mindiff = 1 + b[#b] - b[1]
   for _, c in ipairs(windows(b, 2, 1)) do
      local d = c[2] - c[1]
      if d < mindiff then
         out = {}
         mindiff = d
      end
      if d == mindiff then
         table.insert(out, c)
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

if recursive_compare(minabsdiff({4, 2, 1, 3}), {{1, 2}, {2, 3}, {3, 4}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(minabsdiff({10, 100, 20, 30}), {{10, 20}, {20, 30}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(minabsdiff({-5, -2, 0, 3}), {{-2, 0}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(minabsdiff({8, 1, 15, 3}), {{1, 3}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(minabsdiff({12, 5, 9, 1, 15}), {{9, 12}, {12, 15}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

