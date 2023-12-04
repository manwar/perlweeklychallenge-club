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

function largestofthree(digits)
   ordered = digits
   table.sort(ordered, function (i,j) return i < j end)
   local mx = 0
   for n = #ordered, 1, -1 do
      for _a, c in combinations(ordered, n) do
         local t = 0
         for _b, d in ipairs(c) do
            t = t * 10 + d
         end
         if t > mx and t % 3 == 0 then
            mx = t
         end
      end
   end
   return mx
end

if largestofthree({8, 1, 9}) == 981 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if largestofthree({8, 6, 7, 1, 0}) == 8760 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

