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

function stringscore(a)
   local out = 0
   local c = split(a)
   for n = 1, #c - 1 do
      out = out + math.abs(string.byte(c[n]) - string.byte(c[n + 1]))
   end
   return out
end

if stringscore("hello") == 13 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if stringscore("perl") == 30 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if stringscore("raku") == 37 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

