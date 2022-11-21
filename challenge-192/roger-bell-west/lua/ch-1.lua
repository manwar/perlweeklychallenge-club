#! /usr/bin/lua

function binaryflip(n)
   local m = n
   local r = 0
   while m > 0 do
      m = m >> 1
      r = r + 1
   end
   return (1 << r) - 1 - n
end

if binaryflip(5) == 2 then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if binaryflip(4) == 3 then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if binaryflip(6) == 1 then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
