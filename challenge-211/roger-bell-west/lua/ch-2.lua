#! /usr/bin/lua

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

function sum(t)
   local ss = 0
   for i, k in ipairs(t) do
      ss = ss + k
   end
   return ss
end

function splitsameaverage(a)
   local ss = sum(a)
   local ml = #a
   local mx = ml // 2
   local ssa = false
   for n = 1, mx do
      for i, c in combinations(a, n) do
         local ca = sum(c)
         if (ca / n) == (ss - ca) / (ml - n) then
            ssa = true
            break
         end
      end
      if ssa then
         break
      end
   end
   return ssa
end

if splitsameaverage({1, 2, 3, 4, 5, 6, 7, 8}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not splitsameaverage({1, 3}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if splitsameaverage({1, 2, 3}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

