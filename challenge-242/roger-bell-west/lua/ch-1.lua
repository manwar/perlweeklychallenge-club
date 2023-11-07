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

function unique(a)
   local ss = {}
   local b = {}
   for _, i in ipairs(a) do
      if ss[i] == nil then
         table.insert(b, i)
         ss[i] = true
      end
   end
   return b
end

function halfmissing(a, bh)
   local c = {}
   for _, i in ipairs(a) do
      if bh[i] == nil then
         table.insert(c, i)
      end
   end
   return unique(c)
end

function toset(a)
   local ss = {}
   for _, i in ipairs(a) do
      ss[i] = true
   end
   return ss
end


function missingmembers(a, b)
   local ah = toset(a)
   local bh = toset(b)
   return {
      halfmissing(a, bh),
      halfmissing(b, ah)
   }
end

if recursive_compare(missingmembers({1, 2, 3}, {2, 4, 6}), {{1, 3}, {4, 6}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(missingmembers({1, 2, 3, 3}, {1, 1, 2, 2}), {{3}, {}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

