#! /usr/bin/lua

function is_vowel(c)
   if string.find(string.lower(c), "[aeiou]") == 1 then
      return true
   else
      return false
   end
end

function reversevowels(a)
   local p = {}
   local q = {}
   for i = 1, string.len(a) do
      local c = string.sub(a, i, i)
      table.insert(p, c)
      if is_vowel(c) then
         table.insert(q, c)
      end
   end
   local qi = #q
   local o = ""
   for _, c in ipairs(p) do
      if is_vowel(c) then
         nc = q[qi]
         qi = qi - 1
         if string.upper(c) == c then
            nc = string.upper(nc)
         else
            nc = string.lower(nc)
         end
         o = o .. nc
      else
         o = o .. c
      end
   end
   return o
end

if reversevowels("Raku") == "Ruka" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if reversevowels("Perl") == "Perl" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if reversevowels("Julia") == "Jaliu" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if reversevowels("Uiua") == "Auiu" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

