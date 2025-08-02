#! /usr/bin/lua

function threepower(n0)
   if n0 == 0 then
      return false
   end
   local n = math.abs(n0)
   local lo = 1
   local hi = math.floor(n / 2)
   while true do
      local t= math.floor((lo + hi) / 2)
      local c = t * t * t
      if c == n then
         return true
      end
      if lo == t then
         return false
      end
      if c < n then
         lo = t
      else
         hi = t
      end
   end
end

if threepower(27) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not threepower(0) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not threepower(6) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

