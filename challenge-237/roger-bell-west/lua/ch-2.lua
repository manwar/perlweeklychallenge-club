#! /usr/bin/lua

function maximisegreatness(a)
   local b = a
   table.sort(b)
   local g = 0
   for _, c in ipairs(b) do
      if c > b[g + 1] then
         g = g + 1
      end
   end
   return g
end

if maximisegreatness({1, 3, 5, 2, 1, 3, 1}) == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maximisegreatness({1, 2, 3, 4}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

