#! /usr/bin/lua

function parsecomplex(a)
   local a, b = string.match(a, "^%(?([-%d]+)%)?%+%(?([-%d]+)%)?i$")
   if a ~= nil then
      return { a, b }
   else
      return { 0, 0 }
   end
end

function complexnumber(aa, bb)
   local ab = parsecomplex(aa)
   local a = ab[1]
   local b = ab[2]
   local cd = parsecomplex(bb)
   local c = cd[1]
   local d = cd[2]
   local ca = a * c - b * d
   local cb = a * d + b * c
   if cb < 0 then
      cb = "(" ..  math.floor(cb) .. ")"
   else
      cb = math.floor(cb)
   end
   ca = math.floor(ca)
   return ca .. "+" .. cb .. "i"
end
  

if complexnumber("1+1i", "1+1i") == "0+2i" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if complexnumber("1+(-1)i", "1+(-1)i") == "0+(-2)i" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if complexnumber("0+3i", "0+4i") == "-12+0i" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if complexnumber("3+4i", "3+(-4)i") == "25+0i" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if complexnumber("50+-20i", "-10+30i") == "100+1700i" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

