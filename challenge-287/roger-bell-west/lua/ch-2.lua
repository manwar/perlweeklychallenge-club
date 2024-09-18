#! /usr/bin/lua

function validnumber(a) 
   local integer = "[-+]?%d+"
   local float1 = "[-+]?%d+%.%d*"
   local float2 = "[-+]?%d*%.%d+"
   return
      string.match(a, "^" .. integer .. "$") ~= nil or
      string.match(a, "^" .. float1 .. "$") ~= nil or
      string.match(a, "^" .. float2 .. "$") ~= nil or
      string.match(a, "^" .. integer .. "[Ee]" .. integer .. "$") ~= nil or
      string.match(a, "^" .. float1 .. "[Ee]" .. integer .. "$") ~= nil or
      string.match(a, "^" .. float2 .. "[Ee]" .. integer .. "$") ~= nil
end

if validnumber("1") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not validnumber("a") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not validnumber(".") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not validnumber("1.2e4.2") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if validnumber("-1.") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if validnumber("+1E-8") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if validnumber(".44") then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

