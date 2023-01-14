#! /usr/bin/lua

function goodtriplets(a, x, y, z)
   local c = 0
   for i = 1, #a - 2 do
      for j = i + 1, #a - 1 do
         if math.abs(a[i] - a[j]) <= x then
            for k = j + 1, #a do
               if math.abs(a[j] - a[k]) <= y and
                  math.abs(a[i] - a[k]) <= z then
                  c = c + 1
               end
            end
         end
      end
   end
   return c
end

if goodtriplets({3, 0, 1, 1, 9, 7}, 7, 2, 3) == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if goodtriplets({1, 1, 2, 2, 3}, 0, 0, 1) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

