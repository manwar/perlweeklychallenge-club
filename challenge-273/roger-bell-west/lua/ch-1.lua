#! /usr/bin/lua

function percentageofcharacter(a, c)
   local d = string.len(a)
   local n = 0
   for w in string.gmatch(a, c) do
      n = n + 1
   end
   return (100 * n + d // 2) // d
end

if percentageofcharacter("perl", "e") == 25 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if percentageofcharacter("java", "a") == 50 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if percentageofcharacter("python", "m") == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if percentageofcharacter("ada", "a") == 67 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if percentageofcharacter("ballerina", "l") == 22 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if percentageofcharacter("analitik", "k") == 13 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

