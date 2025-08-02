#! /usr/bin/lua

function countequaldivisible(a, k)
   local s = 0
   for i = 1, #a-1 do
      for j = i + 1, #a do
         if a[i] == a[j] and (i-1) * (j-1) % k == 0 then
            s = s + 1
         end
      end
   end
   return s
end

if countequaldivisible({3, 1, 2, 2, 2, 1, 3}, 2) == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if countequaldivisible({1, 2, 3}, 1) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

