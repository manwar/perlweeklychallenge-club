#! /usr/bin/lua

function matchstring(a)
   local out = {}
   local s = {}
   for _i, x in ipairs(a) do
      if s[x] == nil then
         for _j, y in ipairs(a) do
            if #y > #x and string.find(y, x, 1, true) ~= nul then
               table.insert(out, x)
               break
            end
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

if recursive_compare(matchstring({"cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat"}), {"cat", "dog", "dogcat", "rat"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(matchstring({"hello", "hell", "world", "wor", "ellow", "elloworld"}), {"hell", "world", "wor", "ellow"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(matchstring({"a", "aa", "aaa", "aaaa"}), {"a", "aa", "aaa"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(matchstring({"flower", "flow", "flight", "fl", "fli", "ig", "ght"}), {"flow", "fl", "fli", "ig", "ght"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(matchstring({"car", "carpet", "carpenter", "pet", "enter", "pen", "pent"}), {"car", "pet", "enter", "pen", "pent"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

