#! /usr/bin/lua

function defrangip(a)
   return string.gsub(a, "[.]", "[.]")
   end

if defrangip("1.1.1.1") == "1[.]1[.]1[.]1" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if defrangip("255.101.1.0") == "255[.]101[.]1[.]0" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

