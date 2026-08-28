#! /usr/bin/lua

function secretsanta(n)
   if n == 0 then
      return 1
   end
   if n == 1 then
      return 0
   end
   return (n - 1) * (secretsanta(n - 1) + secretsanta(n - 2))
end

if secretsanta(1) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if secretsanta(2) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if secretsanta(3) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if secretsanta(4) == 9 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if secretsanta(5) == 44 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

