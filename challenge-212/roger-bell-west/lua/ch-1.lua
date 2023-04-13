#! /usr/bin/lua

function jumpingletters(word, jump)
   local s = {}
   for i, j in ipairs(jump) do
      local c = string.byte(word, i)
      local d = c + j % 26
      if (c <= 90 and d > 90) or d > 122 then
         d = d - 26
      end
      table.insert(s, d)
   end
   return string.char(table.unpack(s))
end

if jumpingletters("Perl", {2, 22, 19, 9}) == "Raku" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if jumpingletters("Raku", {24, 4, 7, 17}) == "Perl" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

