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

function decryptstring(a)
   local out = ""
   local c = split(a)
   local s = 1
   while s <= #c do
      local m = c[s]
      if s + 2 <= #c and c[s + 2] == "#" then
         m = m * 10 + c[s + 1]
         s = s + 2
      end
      s = s + 1
      out = out .. string.char(m + 96)
   end
   return out
end


if decryptstring("10#11#12") == "jkab" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if decryptstring("1326#") == "acz" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if decryptstring("25#24#123") == "yxabc" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if decryptstring("20#5") == "te" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if decryptstring("1910#26#") == "aijz" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

