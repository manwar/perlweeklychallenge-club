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

function jd2ymd(jd)
   local y = 4716
   local v = 3
   local j = 1401
   local u = 5
   local m = 2
   local s = 153
   local n = 12
   local w = 2
   local r = 4
   local B = 274277
   local p = 1461
   local C = -38
   local f = jd + j + idiv((idiv(4 * jd + B, 146097)*3), 4) + C
   local e = r * f + v
   local g = idiv(e % p, r)
   local h = u * g + w
   local D = idiv(h % s, u) + 1
   local M = (idiv(h, s) + m) % n + 1
   local Y = idiv(e, p) - y + idiv(n + m - M, n)
   return {Y, M, D}
end

function seizetheday(year, month, weekcount, dayofweek)
   local dt = ymd2jd(year, month, 1)
   local wd = jd2dow(dt)
   if wd == 0 then
      wd = 7
   end
   if wd ~= dayofweek then
      dt = dt + (dayofweek - wd + 7) % 7
   end
   if weekcount > 1 then
      dt = dt + 7 * (weekcount - 1)
   end
   nd = jd2ymd(dt)
   if nd[1] ~= year or nd[2] ~= month then
      return 0
   end
   return nd[3]
end

if seizetheday(2024, 4, 3, 2) == 16 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if seizetheday(2025, 10, 2, 4) == 9 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if seizetheday(2026, 8, 5, 3) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

