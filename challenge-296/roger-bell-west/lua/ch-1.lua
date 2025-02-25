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

function compressedunit(count, letter)
   local out = ""
   if count > 1 then
      out = out .. tostring(count)
   end
   out = out .. letter
   return out
end

function stringcompression(a)
   local out = ""
   local lastchar = ""
   local count = 0
   for _,c in ipairs(split(a)) do
      if count == 0 or c ~= lastchar then
         if count > 0 then
            out = out .. compressedunit(count, lastchar)
         end
         lastchar = c
         count = 0
      end
      count = count + 1
   end
   if count > 0 then
      out = out .. compressedunit(count, lastchar)
   end
   return out
end

function stringdecompression(a)
   local out = ""
   local count = 0
   for _,c in ipairs(split(a)) do
      if c >= "0" and c <= "9" then
         count = count * 10 + tonumber(c)
      else
         if count == 0 then
            count = 1
         end
         out = out .. string.rep(c, count)
         count = 0
      end
   end
   return out
end
   
if stringcompression("abbc") == "a2bc" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if stringcompression("aaabccc") == "3ab3c" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if stringcompression("abcc") == "ab2c" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if stringdecompression("a2bc") == "abbc" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if stringdecompression("3ab3c") == "aaabccc" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if stringdecompression("ab2c") == "abcc" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

