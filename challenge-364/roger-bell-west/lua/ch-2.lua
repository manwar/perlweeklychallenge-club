#! /usr/bin/lua

function goalparser(a)
   local out = ""
   local s = 1
   while s <= #a do
      if string.find(a, "G", s, true) == s then
         s = s + 1
         out = out .. "G"
      elseif string.find(a, "()", s, true) == s then
         s = s + 2
         out = out .. "o"
      elseif string.find(a, "(al)", s, true) == s then
         s = s + 4
         out = out .. "al"
      else
         return ""
      end
   end
   return out
end

if goalparser("G()(al)") == "Goal" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if goalparser("G()()()()(al)") == "Gooooal" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if goalparser("(al)G(al)()()") == "alGaloo" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if goalparser("()G()G") == "oGoG" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if goalparser("(al)(al)G()()") == "alalGoo" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

