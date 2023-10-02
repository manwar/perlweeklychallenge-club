#! /usr/bin/lua

function keys(t)
   local a = {}
   for k, v in pairs(t) do
      table.insert(a, k)
   end
   return a
end

function combinations(arr, k)
   local c = {}
   for i = 1, k do
      table.insert(c, i)
   end
   table.insert(c, #arr + 1)
   table.insert(c, 0)
   local out = {}
   while true do
      local inner = {}
      for i = k, 1, -1 do
         table.insert(inner, arr[c[i]])
      end
      table.insert(out, inner)
      local j = 1
      while c[j] + 1 == c[j + 1] do
         c[j] = j
         j = j + 1
      end
      if j > k then
         break
      end
      c[j] = c[j] + 1
   end
   return ipairs(out)
end

function unequaltriplets(utl)
   local utc = {}
   for _i, n in ipairs(utl) do
      if utc[n] == nil then
         utc[n] = 1
      else
         utc[n] = utc[n] + 1
      end
   end
   local kl = keys(utc)
   if #kl < 3 then
      return 0
   end
   local out = 0
   for _, c in combinations(kl, 3) do
      out = out + utc[c[1]] * utc[c[2]] * utc[c[3]]
   end
   return out
end

if unequaltriplets({4, 4, 2, 4, 3}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if unequaltriplets({1, 1, 1, 1, 1}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if unequaltriplets({4, 7, 1, 10, 7, 4, 1, 1}) == 28 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

