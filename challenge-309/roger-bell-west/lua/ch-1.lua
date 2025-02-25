#! /usr/bin/lua

function mingap(a)
   local mg = a[#a] - a[1]
   local mv = 0
   for i = 2, #a do
      local delta = a[i] - a[i - 1]
      if delta < mg then
         mg = delta
         mv = a[i]
      end
   end
   return mv
end

if mingap({2, 8, 10, 11, 15}) == 11 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if mingap({1, 5, 6, 7, 14}) == 6 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if mingap({8, 20, 25, 28}) == 28 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

