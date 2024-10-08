#! /usr/bin/lua

function doubleexist(a)
   for i = 1, #a - 1 do
      for j = i + 1, #a do
         if a[i] == 2 * a[j] or a[j] == 2 * a[i] then
            return true
         end
      end
   end
   return false
end

if doubleexist({6, 2, 3, 3}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not doubleexist({3, 1, 4, 13}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if doubleexist({2, 1, 4, 2}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

