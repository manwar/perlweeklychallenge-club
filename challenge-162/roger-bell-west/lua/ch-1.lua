#! /usr/bin/lua

function generate(in0)
   local in1=string.gsub(in0,"%D+","")
   if string.len(in1) < 12 then
      return 99
   end
   local s = 0
   local m = 1
   local zero = string.byte("0")
   for i = 1, 12 do
      s = s + m * (string.byte(string.sub(in1,i,i)) - zero)
      m = 4 - m
   end
   return (10 - (s % 10)) % 10
end

function validate(in0)
   local in1=string.gsub(in0,"%D+","")
   if string.len(in1) ~= 13 then
      return false
   end
   local zero = string.byte("0")
   return generate(in1) == string.byte(string.sub(in1,13,13)) - zero
end

if generate("978-0-306-40615-") == 7 then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if generate("978-0-306-40615-7") == 7 then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if validate("978-0-306-40615-7") then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if not validate("978-0-306-46015-7") then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
