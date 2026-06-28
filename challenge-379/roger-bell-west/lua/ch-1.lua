#! /usr/bin/lua

function reversestring(t)
   local u = ""
   string.gsub(t,
               "(.)",
               function(c)
                  u = c .. u
               end
   )
   return u
end

if reversestring("") == "" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if reversestring("reverse the given string") == "gnirts nevig eht esrever" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

