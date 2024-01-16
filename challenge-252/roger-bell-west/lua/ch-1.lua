#! /usr/bin/lua

function specialnumbers(a)
   local t = 0
   for i, n in ipairs(a) do
      if #a % i == 0 then
         t = t + n * n
      end
   end
   return t
end

if specialnumbers({1, 2, 3, 4}) == 21 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if specialnumbers({2, 7, 1, 19, 18, 3}) == 63 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

