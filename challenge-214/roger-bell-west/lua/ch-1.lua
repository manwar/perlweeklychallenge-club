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

-- Roger's lualib
function keys(t)
   local a = {}
   for k, v in pairs(t) do
      table.insert(a, k)
   end
   return a
end

function rankscore(a)
   local av = {}
   for i, s in ipairs(a) do
      if av[s] == nil then
         av[s] = 1
      else
         av[s] = av[s] + 1
      end
   end
   local kk = keys(av)
   table.sort(kk, function (aa, bb) return bb < aa end)
   local rank = 1
   local tab = {}
   for i, k in ipairs(kk) do
      local siz = av[k]
      local r = ""
      if rank <= 3 then
         r = string.sub("GSB", rank, rank)
      else
         r = tostring(rank)
      end
      if siz > 1 then
         r = r .. "="
      end
      tab[k] = r
      rank = rank + siz
   end
   local out = {}
   for i, s in ipairs(a) do
      table.insert(out, tab[s])
   end
   return out
end

if recursive_compare(rankscore({1, 2, 4, 3, 5}), {"5", "4", "S", "B", "G"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(rankscore({8, 5, 6, 7, 4}), {"G", "4", "B", "S", "5"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(rankscore({3, 5, 4, 2}), {"B", "G", "S", "4"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(rankscore({2, 5, 2, 1, 7, 5, 1}), {"4=", "S=", "4=", "6=", "G", "S=", "6="}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

