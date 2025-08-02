#! /usr/bin/lua

function chars(str)
   local c = {}
   for i = 1, string.len(str) do
      table.insert(c, string.sub(str, i, i))
   end
   return c
end

function oddcharacter(s, t)
   local ss = {}
   for _, c in ipairs(chars(s)) do
      if ss[c] == nil then
         ss[c] = 1
      else
         ss[c] = ss[c] + 1
      end
   end
   for _, c in ipairs(chars(t)) do
      if ss[c] ~= nil and ss[c] > 0 then
         ss[c] = ss[c] - 1
         if ss[c] == 0 then
            ss[c] = nil
         end
      else
         return c
      end
   end
   return "@"
end

if oddcharacter("Perl", "Preel") == "e" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if oddcharacter("Weekly", "Weeakly") == "a" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if oddcharacter("Box", "Boxy") == "y" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

