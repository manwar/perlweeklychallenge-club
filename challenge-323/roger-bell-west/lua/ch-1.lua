#! /usr/bin/lua

function incrementdecrement(operations)
   local p = 0
   for _, s in ipairs(operations) do
      if string.sub(s, 2, 2) == "+" then
         p = p + 1
      else
         p = p - 1
      end
   end
   return p
end

if incrementdecrement({"--x", "x++", "x++"}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if incrementdecrement({"x++", "++x", "x++"}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if incrementdecrement({"x++", "++x", "--x", "x--"}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

