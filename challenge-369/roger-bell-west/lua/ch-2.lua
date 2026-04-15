#! /usr/bin/lua

function groupdivision(a0, sz, pad)
   local a = a0
   while #a % sz ~= 0 do
      a = a .. pad
   end
   local out = {}
   for i = 1, #a, sz do
      table.insert(out, string.sub(a, i, i + sz))
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

if recursive_compare(groupdivision("RakuPerl", 4, "*"), {"Raku", "Perl"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(groupdivision("Python", 5, "0"), {"Pytho", "n0000"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(groupdivision("12345", 3, "x"), {"123", "45x"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(groupdivision("HelloWorld", 3, "_"), {"Hel", "loW", "orl", "d__"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(groupdivision("AI", 5, "!"), {"AI!!!"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

