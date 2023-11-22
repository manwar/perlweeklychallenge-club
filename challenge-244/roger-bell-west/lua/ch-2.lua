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

function grouphero(nums0)
   local nums = nums0
   table.sort(nums, function (i,j) return j < i end)
   local sum = 0
   for l = 1, #nums do
      for _, c in combinations(nums, l) do
         sum = sum + c[#c] * c[#c] * c[1]
      end
   end
   return sum
end

if grouphero({2, 1, 4}) == 141 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

