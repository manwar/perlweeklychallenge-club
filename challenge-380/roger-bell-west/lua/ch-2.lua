#! /usr/bin/lua

function split(t)
   local cl = {}
   string.gsub(t,
               "(.)",
               function(c)
                  table.insert(cl, c)
               end
   )
   return cl
end

function reversedegree(a)
   local t = 0
   local z0 = string.byte("z") + 1
   for i, c in ipairs(split(a)) do
      t = t + (z0 - string.byte(c)) * i
   end
   return t
end

if reversedegree("z") == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if reversedegree("a") == 26 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if reversedegree("bbc") == 147 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if reversedegree("racecar") == 560 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if reversedegree("zyx") == 14 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

