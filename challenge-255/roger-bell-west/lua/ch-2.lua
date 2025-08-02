#! /usr/bin/lua

function mostfrequentword(para, banned)
   local words = {}
   for c in string.gmatch(para, "%a+") do
      if words[c] == nil then
         words[c] = 1
      else
         words[c] = words[c] + 1
      end
   end
   words[banned] = nil
   local m = 0
   for k, v in pairs(words) do
      m = math.max(m, v)
   end
   for k, v in pairs(words) do
      if v == m then
         return k
      end
   end
end

if mostfrequentword("Joe hit a ball, the hit ball flew far after it was hit.", "hit") == "ball" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if mostfrequentword("Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.", "the") == "Perl" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")
