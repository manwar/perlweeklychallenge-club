#! /usr/bin/lua

function concatenate(as)
   local o = ""
   for _, v in ipairs(as) do
      o = o .. v
   end
   return o
end

function samestring(a, b)
   return concatenate(a) == concatenate(b)
end

if samestring({"ab", "c"}, {"a", "bc"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not samestring({"ab", "c"}, {"ac", "b"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if samestring({"ab", "cd", "e"}, {"abcde"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

