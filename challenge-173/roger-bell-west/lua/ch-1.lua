#! /usr/bin/lua

function esthetic10(n)
   return esthetic(n, 10)
end

function esthetic(n0, base)
   local n = n0
   local pdigit
   local ch = false
   while n > 0 do
      local digit = n % base
      if ch and math.abs(digit - pdigit) ~= 1 then
         return false
      end
      ch = true
      pdigit = digit
      n = math.floor(n / base)
   end
   return true
end

if esthetic10(5456) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if not esthetic10(120) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if esthetic10(12) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if esthetic10(5654) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if not esthetic10(890) then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
