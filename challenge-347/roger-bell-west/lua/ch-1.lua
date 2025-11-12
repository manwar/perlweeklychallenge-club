#! /usr/bin/lua
function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

function formatdate(a)
   local d, m, y = string.match(a, "^(%d+)%l+ (%u%l+) (%d+)$")
   local tab = {
      Jan = 1;
      Feb = 2;
      Mar = 3;
      Apr = 4;
      May = 5;
      Jun = 6;
      Jul = 7;
      Aug = 8;
      Sep = 9;
      Oct = 10;
      Nov = 11;
      Dec = 12
   }
   m = tab[m]
   return string.format("%04d-%02d-%02d", y, m, d)
   end

if formatdate("1st Jan 2025") == "2025-01-01" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if formatdate("22nd Feb 2025") == "2025-02-22" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if formatdate("15th Apr 2025") == "2025-04-15" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if formatdate("23rd Oct 2025") == "2025-10-23" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if formatdate("31st Dec 2025") == "2025-12-31" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

