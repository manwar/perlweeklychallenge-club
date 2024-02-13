#! /usr/bin/lua

function mergestrings(a, b)
   local out = ""
   for i = 1, math.max(string.len(a), string.len(b)) do
      if i <= string.len(a) then
         out = out .. string.sub(a, i, i)
      end
      if i <= string.len(b) then
         out = out .. string.sub(b, i, i)
      end
   end
   return out
end

if mergestrings("abcd", 1234) == "a1b2c3d4" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if mergestrings("abc", 12345) == "a1b2c345" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if mergestrings("abcde", 123) == "a1b2c3de" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

