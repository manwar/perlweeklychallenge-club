#! /usr/bin/lua

function acronym(strs, chk)
   local cm = ""
   for _, s in ipairs(strs) do
      cm = cm .. string.sub(s, 1, 1)
   end
   return string.lower(cm) == string.lower(chk)
end

if acronym({"Perl", "Python", "Pascal"}, "ppp") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not acronym({"Perl", "Raku"}, "rp") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if acronym({"Oracle", "Awk", "C"}, "oac") then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

