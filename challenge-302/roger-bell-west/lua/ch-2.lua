#! /usr/bin/lua

function stepbystep(a)
   local mv = 0
   local tot = 0
   for _, s in ipairs(a) do
      tot = tot + s
      if mv > tot then
         mv = tot
      end
   end
   return 1 - mv
end

if stepbystep({-3, 2, -3, 4, 2}) == 5 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if stepbystep({1, 2}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if stepbystep({1, -2, -3}) == 5 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

