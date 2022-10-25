#! /usr/bin/lua

function totalzero(aa, bb)
   if aa == 0 and bb == 0 then
      return 0
   end
   local a = aa
   local b = bb
   local ct = 1
   while true do
      if a == b then
         return ct
      end
      ct = ct + 1
      if a > b then
         a = a - b
      else
         b = b - a
      end
   end
end

if (totalzero(5, 4) == 5) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if (totalzero(4, 6) == 3) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if (totalzero(2, 5) == 4) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if (totalzero(3, 1) == 3) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if (totalzero(7, 4) == 5) then
   io.write("Pass")
else
   io.write("FAIL")
end

print("")
