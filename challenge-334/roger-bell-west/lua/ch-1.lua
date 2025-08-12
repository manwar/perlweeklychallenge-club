#! /usr/bin/lua

function rangesum(a, s, e)
   local t = 0
   for i = s + 1, e + 1 do
      t = t + a[i]
   end
   return t
end

if rangesum({-2, 0, 3, -5, 2, -1}, 0, 2) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if rangesum({1, -2, 3, -4, 5}, 1, 3) == -3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if rangesum({1, 0, 2, -1, 3}, 3, 4) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if rangesum({-5, 4, -3, 2, -1, 0}, 0, 3) == -2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if rangesum({-1, 0, 2, -3, -2, 1}, 0, 2) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

