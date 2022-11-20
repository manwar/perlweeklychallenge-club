#! /usr/bin/lua

function twicelargest(l0)
   local l = l0
   table.sort(l)
   return l[#l] >= 2 * l[#l-1]
end

if not twicelargest({1, 2, 3, 4}) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if twicelargest({1, 2, 0, 5}) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if twicelargest({2, 6, 3, 1}) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if not twicelargest({4, 5, 2, 3}) then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
