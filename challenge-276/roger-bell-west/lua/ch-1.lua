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

function completeday(a)
   local out = 0
   for _, c in combinations(a, 2) do
      if (c[1] + c[2]) % 24 == 0 then
         out = out + 1
      end
   end
   return out
end

if completeday({12, 12, 30, 24, 24}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if completeday({72, 48, 24, 5}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if completeday({12, 18, 24}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

