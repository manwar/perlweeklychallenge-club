#! /usr/bin/lua

function popcount(x0) -- adapted from https://gist.github.com/davidm/2065267
   local x = x0
   local c = 0
   while x ~= 0 do
      x = x & (x - 1)
      c = c + 1
   end
   return c
end

function hammingdistance(a)
   local t = 0
   for i = 1, #a - 1 do
      for j = i + 1, #a do
         t = t + popcount(a[i] ~ a[j])
      end
   end
   return t
end

if hammingdistance({4, 14, 2}) == 6 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if hammingdistance({4, 14, 4}) == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

