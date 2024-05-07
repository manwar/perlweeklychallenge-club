#! /usr/bin/lua

function magicnumber(a, b)
   return math.min(table.unpack(b)) - math.min(table.unpack(a)) 
end

if magicnumber({3, 7, 5}, {9, 5, 7}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if magicnumber({1, 2, 1}, {5, 4, 4}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if magicnumber({2}, {5}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

