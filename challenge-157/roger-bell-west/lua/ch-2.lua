#! /usr/bin/lua

function brazilian(n)
   for b = 2, n-2 do
      local nn = n
      local braz = true
      local digit = nn % b
      while nn > 0 do
         if digit == nn % b then
            nn = nn // b
         else
            braz = false
            break
         end
      end
      if braz then
         return true
      end
   end
   return false
end

if brazilian(7) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if not brazilian(6) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if brazilian(8) then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
