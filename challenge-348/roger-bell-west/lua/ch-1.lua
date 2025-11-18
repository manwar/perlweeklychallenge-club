#! /usr/bin/lua

function split(t)
   local cl = {}
   string.gsub(t,
               "(.)",
               function(c)
                  table.insert(cl, c)
               end
   )
   return cl
end

function is_vowel(c)
   if string.find(c, "[aeiou]") == 1 then
      return true
   else
      return false
   end
end

function stringalike(a)
   if #a % 2 == 1 then
      return false
   end
   local vt = 0
   local mode = 1
   local av = false
   for i,c in ipairs(split(string.lower(a))) do
      if is_vowel(c) then
         av = true
         vt = vt + mode
      end
      if i * 2 == #a then
         mode = -1
      end
   end
   return av and (vt == 0)
end

if not stringalike("textbook") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if stringalike("book") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if stringalike("AbCdEfGh") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not stringalike("rhythmmyth") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not stringalike("UmpireeAudio") then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

