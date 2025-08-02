#! /usr/bin/lua

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

function getlistset(a)
   local la = split(a)
   local ca = {}
   for _, w in ipairs(la) do
      if ca[w] == nil then
         ca[w] = 1
      else
         ca[w] = ca[w] + 1
      end
   end
   local lb = {}
   for _, w in ipairs(la) do
      if ca[w] == 1 then
         table.insert(lb, w)
      end
   end
   return {lb, ca}
end

function uncommonwords(a, b)
   local ta = getlistset(a)
   local la = ta[1]
   local sa = ta[2]
   local tb = getlistset(b)
   local lb = tb[1]
   local sb = tb[2]
   local out = {}
   for _, wx in pairs({{la,sb}, {lb, sa}}) do
      local wl = wx[1]
      local t = wx[2]
      for _, w in ipairs(wl) do
         if t[w] == nil then
            table.insert(out, w)
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

if recursive_compare(uncommonwords("Mango is sweet", "Mango is sour"), {"sweet", "sour"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(uncommonwords("Mango Mango", "Orange"), {"Orange"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(uncommonwords("Mango is Mango", "Orange is Orange"), {}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

