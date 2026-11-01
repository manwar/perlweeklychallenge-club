#! /usr/bin/lua

function map(seq, func)
   local out = {}
   for _, x in ipairs(seq) do
      table.insert(out, func(x))
   end
   return out
end

function reflect(a)
   local p = {}
   local am = a
   while true do
      table.insert(p, am % 2)
      am = am >> 1
      if am == 0 then
         break
      end
   end
   local ar = 0
   local s = #p
   for _, n in ipairs(p) do
      s = s - 1
      ar = ar + n << s
   end
   return ar
end

function binaryreflection(ax)
   local k = map(ax, function(x) return reflect(x) end)
   local i = {}
   for j = 1,#ax do
      table.insert(i, j)
   end
   table.sort(i, function(a, b)
                   if k[a] == k[b] then
                      return ax[a] < ax[b]
                   else
                      return k[a] < k[b]
                   end
                 end)
   return map(i, function(x) return ax[x] end)
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

if recursive_compare(binaryreflection({3, 6, 12}), {3, 6, 12}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(binaryreflection({1, 2, 4, 8}), {1, 2, 4, 8}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(binaryreflection({7, 8, 9, 10}), {8, 10, 7, 9}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(binaryreflection({5, 9, 15, 17}), {5, 9, 15, 17}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(binaryreflection({11, 13, 14, 19}), {14, 13, 11, 19}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

