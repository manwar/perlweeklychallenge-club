#! /usr/bin/lua

function acronyms(a, b)
   local os = ""
   for _, c in ipairs(a) do
      os = os .. string.match(c, "(.)")
   end
   return os == b
end

if acronyms({"Perl", "Weekly", "Challenge"}, "PWC") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if acronyms({"Bob", "Charlie", "Joe"}, "BCJ") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not acronyms({"Morning", "Good"}, "MM") then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

