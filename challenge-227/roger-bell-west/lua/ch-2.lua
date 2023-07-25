#! /usr/bin/lua

function roman2int(roman)
   if roman == "" then
      return 0
   end
   for _, s in ipairs({
      { 'M', 1000 },
      { 'CM', 900 },
      { 'D', 500 },
      { 'CD', 400 },
      { 'C', 100 },
      { 'XC', 90 },
      { 'L', 50 },
      { 'XL', 40 },
      { 'X', 10 },
      { 'IX', 9 },
      { 'V', 5 },
      { 'IV', 4 },
      { 'I', 1 }
   }) do
      if string.find(roman, s[1], 1, true) == 1 then
         return s[2] + roman2int(string.sub(roman, #s[1] + 1))
      end
   end
   return 0
end

function int2roman(n0)
   local number = n0
   local mn = ""
   for _, s in ipairs({
      { 'M', 1000 },
      { 'CM', 900 },
      { 'D', 500 },
      { 'CD', 400 },
      { 'C', 100 },
      { 'XC', 90 },
      { 'L', 50 },
      { 'XL', 40 },
      { 'X', 10 },
      { 'IX', 9 },
      { 'V', 5 },
      { 'IV', 4 },
      { 'I', 1 }
   }) do
      while s[2] <= number do
         mn = mn .. s[1]
         number = number - s[2]
      end
   end
   return mn
end

-- bart at https://stackoverflow.com/questions/1426954/split-string-in-lua
function split(inputstr, sep)
   sep=sep or '%s'
   local t={}
   for field,s in string.gmatch(inputstr, "([^"..sep.."]*)("..sep.."?)") do
      table.insert(t,field)
      if s=="" then
         return t
      end
   end
end

function romanmaths(ax)
   local elems = split(ax, " ")
   local a = roman2int(elems[1])
   local b = roman2int(elems[3])
   local c = -1
   if elems[2] == "+" then
      c = a + b
   elseif elems[2] == "-" then
      c = a - b
   elseif elems[2] == "*" then
      c = a * b
   elseif elems[2] == "/" then
      if a % b == 0 then
         c = a // b
      end
   elseif elems[2] == "**" then
      c = a ^ b
   end
   if c > 3999 or c < 0 then
      return "non potest"
   elseif c == 0 then
      return "nulla"
   else
      return int2roman(c)
   end
end

if roman2int("I") == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if roman2int("II") == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if roman2int("IV") == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if roman2int("IX") == 9 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if roman2int("XXX") == 30 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if roman2int("MDCLXVI") == 1666 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if int2roman(1) == "I" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if int2roman(2) == "II" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if int2roman(4) == "IV" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if int2roman(9) == "IX" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if int2roman(30) == "XXX" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if int2roman(1666) == "MDCLXVI" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if romanmaths("IV + V") == "IX" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if romanmaths("M - I") == "CMXCIX" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if romanmaths("X / II") == "V" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if romanmaths("XI * VI") == "LXVI" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if romanmaths("VII ** III") == "CCCXLIII" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if romanmaths("V - V") == "nulla" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if romanmaths("V / II") == "non potest" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if romanmaths("MMM + M") == "non potest" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if romanmaths("V - X") == "non potest" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

