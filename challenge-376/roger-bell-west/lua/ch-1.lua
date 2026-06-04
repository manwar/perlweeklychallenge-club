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

function chessboardsquares(a, b)
   return checkcolor(a) == checkcolor(b)
end

if chessboardsquares("a7", "f4") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not chessboardsquares("c1", "e8") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not chessboardsquares("b5", "h2") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if chessboardsquares("f3", "h1") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not chessboardsquares("a1", "g8") then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

