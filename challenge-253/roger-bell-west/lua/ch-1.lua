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

-- bart at https://stackoverflow.com/questions/1426954/split-string-in-lua
function split(inputstr, sep)
   sep=sep or '%s'
   local t={}
   for field,s in string.gmatch(inputstr, "([^"..sep.."]*)("..sep.."?)") do
      table.insert(t,field)
      if s=="" then
         return t
      end
   end
end

function splitstrings(a, sep)
   local p = {}
   for _i, s in ipairs(a) do
      for _j, n in ipairs(split(s), sep) do
         if #n > 0 then
            table.insert(p, n)
         end
      end
   end
   return p
end

if recursive_compare(splitstrings({"one.two.three", "four.five", "six"}, "."), {"one", "two", "three", "four", "five", "six"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(splitstrings({"$perl$$", "$$raku$"}, "$"), {"perl", "raku"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

