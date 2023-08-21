#! /usr/bin/lua

function prefixwords(s, p)
   local t = 0
   for _, st in ipairs(s) do
      if string.find(st, p, 1, true) == 1 then
         t = t + 1
      end
   end
   return t 
end

if prefixwords({"pay", "attention", "practice", "attend"}, "at") == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if prefixwords({"janet", "julia", "java", "javascript"}, "ja") == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

