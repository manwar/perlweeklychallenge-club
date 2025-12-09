#! /usr/bin/lua

function arithmeticprogression(a0)
   local epsilon = 0.0001
   local a = a0
   table.sort(a)
   local delta = a[2] - a[1]
   for i = 3, #a do
      if math.abs(a[i] - a[i - 1] - delta) > epsilon then
         return false
      end
   end
   return true
end

if arithmeticprogression({1, 3, 5, 7, 9}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if arithmeticprogression({9, 1, 7, 5, 3}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not arithmeticprogression({1, 2, 4, 8, 16}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if arithmeticprogression({5, -1, 3, 1, -3}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if arithmeticprogression({1.5, 3, 0, 4.5, 6}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

