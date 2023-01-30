#! /usr/bin/lua

function pennypiles(n)
   if n == 0 then
      return 1
   end
   local s = 0
   local j = n - 1
   local k = 2
   while j >= 0 do
      local t = pennypiles(j)
      if math.floor(k / 2) % 2 == 1 then
         s = s + t
      else
         s = s - t
      end
      if k % 2 == 1 then
         j = j - k
      else
         j = j - math.floor(k / 2)
      end
      k = k + 1
   end
   return s
end

if pennypiles(5) == 7 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if pennypiles(10) == 42 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

