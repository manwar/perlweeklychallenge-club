#! /usr/bin/lua

function oddoneout(a)
   local ct = 0
   for _dummy, s in ipairs(a) do
      for i = 2, #s do
         if string.byte(s, i - 1) > string.byte(s, i) then
            ct = ct + 1
            break
         end
      end
   end
   return ct
end

if oddoneout({"abc", "xyz", "tsu"}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if oddoneout({"rat", "cab", "dad"}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if oddoneout({"x", "y", "z"}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

