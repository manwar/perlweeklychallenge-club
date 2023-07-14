#! /usr/bin/lua

function maxwords(a)
   local m = 0
   for i, v in ipairs(a) do
      local ct = 0
      for n, m in string.gmatch(v, "%s") do
         ct = ct + 1
      end
      if ct > m then
         m = ct
      end
   end
   return m + 1
end

if maxwords({"Perl and Raku belong to the same family.", "I love Perl.", "The Perl and Raku Conference."}) == 8 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maxwords({"The Weekly Challenge.", "Python is the most popular guest language.", "Team PWC has over 300 members."}) == 7 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

