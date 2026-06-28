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

function map(seq, func)
   local out = {}
   for _, x in ipairs(seq) do
      table.insert(out, func(x))
   end
   return out
end

function sum(t)
   local ss = 0
   for i, k in ipairs(t) do
      ss = ss + k
   end
   return ss
end

function armstrongnumber(base, limit)
   local out = {}
   for candidate = 0, limit-1 do
      local digits = {}
      if candidate == 0 then
         table.insert(digits, 0)
      else
         local c = candidate
         while c > 0 do
            table.insert(digits, c % base)
            c = c // base
         end
      end
      local dl = #digits
      local test = sum(map(digits, function(x) return x ^ dl end))
      if text == candidate then
         table.insert(out, candidate)
      end
   end
   return out
end

if recursive_compare(armstrongnumber(10, 1000), {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 153, 370, 371, 407}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(armstrongnumber(7, 1000), {0, 1, 2, 3, 4, 5, 6, 10, 25, 32, 45, 133, 134, 152, 250}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(armstrongnumber(16, 1000), {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 342, 371, 520, 584, 645}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

