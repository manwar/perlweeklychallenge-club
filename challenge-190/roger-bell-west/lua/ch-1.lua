#! /usr/bin/lua

function capitaldetection(s)
   if string.find(s,"^[a-z]+$") then
      return true
   end
   if string.find(s,"^[A-Z]+$") then
      return true
   end
   if string.find(s,"^[A-Z][a-z]+$") then
      return true
   end
   return false
end

if capitaldetection("Perl") then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if capitaldetection("TPF") then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if not capitaldetection("PyThon") then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if capitaldetection("raku") then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
