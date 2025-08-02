#! /usr/bin/lua

function elementdigitsum(a)
   local delta = 0
   for _, n0 in ipairs(a) do
      local n = n0 // 10
      local m = 10
      while n > 0 do
         delta = delta + (n % 10) * (m - 1)
         n = n // 10
         m = m * 10
      end
   end
   return delta
end

if elementdigitsum({1, 2, 3, 45}) == 36 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if elementdigitsum({1, 12, 3}) == 9 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if elementdigitsum({1, 2, 3, 4}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if elementdigitsum({236, 416, 336, 350}) == 1296 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

