#! /usr/bin/lua

function firstunique(s)
   local cc = {}
   for c in string.gmatch(s, ".") do
      if cc[c] == nil then
         cc[c] = 1
      else
         cc[c] = cc[c] + 1
      end
   end
   local i = 1
   for c in string.gmatch(s, ".") do
      if cc[c] == 1 then
         return i
      end
      i = i + 1
   end
   return 0
end

if firstunique("Perl Weekly Challenge") == 1 then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if firstunique("Long Live Perl") == 2 then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if firstunique("aabbcc") == 0 then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
