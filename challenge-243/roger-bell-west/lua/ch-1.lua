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

function reversepairs(a)
   local n = 0
   for _, x in combinations(a, 2) do
      if x[2] > 2 * x[1] then
         n = n + 1
      end
   end
   return n
end

if reversepairs({1, 3, 2, 3, 1}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if reversepairs({2, 4, 3, 5, 1}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

