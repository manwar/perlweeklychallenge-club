#! /usr/bin/lua

function cs2xy(a)
   local x = string.byte(a, 1) - string.byte("a")
   local y = string.byte(a, 2) - string.byte("1")
   return {x, y}
end

function checkcolor(a)
   local xy = cs2xy(a)
   return (xy[1] + xy[2]) % 2 == 1
end

if checkcolor("d3") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not checkcolor("g5") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if checkcolor("e6") then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

