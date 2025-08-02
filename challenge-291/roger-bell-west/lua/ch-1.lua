#! /usr/bin/lua

function middleindex(a)
   local r = 0
   local l = 0
   for i, c in ipairs(a) do
      r = r + c
   end
   for i, c in ipairs(a) do
      r = r - c
      if r == l then
         return i - 1
      end
      l = l + c
   end
   return -1
end

if middleindex({2, 3, -1, 8, 4}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if middleindex({1, -1, 4}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if middleindex({2, 5}) == -1 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

