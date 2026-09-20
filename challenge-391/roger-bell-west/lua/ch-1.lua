#! /usr/bin/lua

function arraymedian(a, b)
   local nn = a
   for _, n in ipairs(b) do
      table.insert(nn, n)
   end
   table.sort(nn)
   local i = math.floor(#nn / 2) + 1
   if #nn % 2 == 0 then
      return (nn[i - 1] + nn[i]) / 2
   else
      return nn[i]
   end
end

if arraymedian({2}, {4}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if arraymedian({1, 2, 3}, {7, 8, 9, 10}) == 7 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if arraymedian({}, {10, 20, 30, 40}) == 25 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if arraymedian({100}, {1, 2, 3, 4, 5, 6, 7}) == 4.5 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if arraymedian({1, 2, 2}, {2, 2, 3}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

