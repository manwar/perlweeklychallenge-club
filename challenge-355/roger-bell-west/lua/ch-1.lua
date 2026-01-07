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

function thousandseparator(a)
   local out = ""
   local s = split(tostring(a))
   local offset = 2 - (#s % 3)
   for i, d in ipairs(s) do
      if i > 1 and (i + offset) % 3 == 0 then
         out = out .. ','
      end
      out = out .. d
   end
   return out
end

if thousandseparator(123) == "123" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if thousandseparator(1234) == "1,234" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if thousandseparator(1000000) == "1,000,000" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if thousandseparator(1) == "1" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if thousandseparator(12345) == "12,345" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

