#! /usr/bin/lua

function numberplacement(a0, ct)
   local a = a0
   table.insert(a, 1, 1)
   table.insert(a, 1)
   local s = 0
   local tt = 0
   for i = 2, #a do
      if a[i - 1] == 1 and a[i] == 0 then
         s = i
      elseif a[i - 1] == 0 and a[i] == 1 then
         tt = tt + (i - s) // 2
      end
   end
   return ct <= tt
end

if numberplacement({1, 0, 0, 0, 1}, 1) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not numberplacement({1, 0, 0, 0, 1}, 2) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if numberplacement({1, 0, 0, 0, 0, 0, 0, 0, 1}, 3) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

