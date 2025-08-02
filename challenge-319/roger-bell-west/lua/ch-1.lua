#! /usr/bin/lua

function wordcount(a)
   local ct = 0
   for _, w in ipairs(a) do
      if string.match(w, "^[aeiou]") or string.match(w, "[aeiou]$") then
         ct = ct + 1
         end
   end
   return ct
end

if wordcount({"unicode", "xml", "raku", "perl"}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if wordcount({"the", "weekly", "challenge"}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if wordcount({"perl", "python", "postgres"}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

