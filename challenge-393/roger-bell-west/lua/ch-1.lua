#! /usr/bin/lua

function pythagorasmultiplied(n)
   local squared = {}
   local ct = 0
   for c = 5, n do
      local csquared = c * c
      for a = 1, c - 2 do
         local asquared = a * a
         for b = a + 1, c - 1 do
            local bsquared = b * b
            local tot = asquared + bsquared
            if tot > csquared then
               break
            end
            if tot == csquared then
               ct = ct + 1
            end
         end
      end
   end
   return ct * 2
end

if pythagorasmultiplied(20) == 12 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if pythagorasmultiplied(7) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if pythagorasmultiplied(1) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if pythagorasmultiplied(15) == 8 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if pythagorasmultiplied(30) == 22 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

