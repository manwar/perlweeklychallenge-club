#! /usr/bin/lua

function sumdifference(a)
   local delta = 0
   for _, x in ipairs(a) do
      if x >= 10 then
         local digitsum = 0
         local xa = x
         while xa > 0 do
            digitsum = digitsum + xa % 10
            xa = xa // 10
         end
         delta = delta + x - digitsum
      end
   end
   return delta
end

if sumdifference({1, 23, 4, 5}) == 18 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if sumdifference({1, 2, 3, 4, 5}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if sumdifference({1, 2, 34}) == 27 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

