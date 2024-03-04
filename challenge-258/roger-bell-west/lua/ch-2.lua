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

function sumofvalues(a, k)
   local s = 0
   for i, v in ipairs(a) do
      if popcount(i - 1) == k then
         s = s + v
      end
   end
   return s
end

if sumofvalues({2, 5, 9, 11, 3}, 1) == 17 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if sumofvalues({2, 5, 9, 11, 3}, 2) == 11 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if sumofvalues({2, 5, 9, 11, 3}, 0) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

