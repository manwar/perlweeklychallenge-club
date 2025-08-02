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

function splitstring(a)
   local n = 0
   for _, cc in ipairs(split(string.lower(a))) do
      if string.find(cc, "[aeiou]") == 1 then
         n = n + 1
      end
   end
   return n % 2 == 0
end

if not splitstring("perl") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if splitstring("book") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if splitstring("goodmorning") then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

