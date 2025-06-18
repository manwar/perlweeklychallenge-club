#! /usr/bin/lua

function idiv(a0, b)
   local a = math.abs(a0)
   local q = a // b
   if a0 < 0 then
      q = -q
   end
   return q
end

function ymd2jd(y, m, d)
   local mn = idiv(m - 14, 12)
   return idiv((y + 4800 + mn) * 1461, 4) + idiv((m - 2 - 12 * mn) * 367, 12) - idiv(idiv(y + 4900 + mn, 100) * 3, 4) + d - 32075
end

function dayoftheyear(a)
   local _a, _b, y, m, d = string.find(a, "([0-9][0-9][0-9][0-9])-([0-9][0-9])-([0-9][0-9])")
   local d1 = ymd2jd(y, m, d)
   local d0 = ymd2jd(y, 1, 1)
   return d1 - d0 + 1
end

if dayoftheyear("2025-02-02") == 33 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if dayoftheyear("2025-04-10") == 100 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if dayoftheyear("2025-09-07") == 250 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

