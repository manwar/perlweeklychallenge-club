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

function jd2dow(jd)
   return (jd + 1) % 7
end

function friday13th(y)
   local f = 0
   for m = 1, 12 do
      if jd2dow(ymd2jd(y, m, 13)) == 5 then
         f = f + 1
      end
   end
   return f
end

if friday13th(2023) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

