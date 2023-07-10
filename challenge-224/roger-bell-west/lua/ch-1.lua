#! /usr/bin/lua

function word2map(word)
   local m = {}
   for c in string.gmatch(string.lower(word), "%a") do
      if m[c] == nil then
         m[c] = 1
      else
         m[c] = m[c] + 1
      end
   end
   return m
end

function specialnotes(chars, word)
   local cm = word2map(chars)
   local f = word2map(word)
   local valid = true
   for c, _ in pairs(f) do
      if cm[c] == nil or f[c] > cm[c] then
         valid = false
         break
      end
   end
   return valid
end

if not specialnotes("abc", "xyz") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if specialnotes("scriptinglanguage", "perl") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if specialnotes("aabbcc", "abc") then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

