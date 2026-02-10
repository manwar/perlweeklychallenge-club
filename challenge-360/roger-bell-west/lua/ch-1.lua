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

function join(t)
   local out=""
   for i, v in ipairs(t) do
      out = out .. v
   end
   return out
end

function textjustifier(intxt, width)
   local working = {}
   for _ = 1, width do
      table.insert(working, "*")
   end
   local offset = math.floor((width - #intxt) / 2)
   for i, c in ipairs(split(intxt)) do
      working[i + offset] = c
   end
   return join(working)
end

if textjustifier("Hi", 5) == "*Hi**" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if textjustifier("Code", 10) == "***Code***" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if textjustifier("Hello", 9) == "**Hello**" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if textjustifier("Perl", 4) == "Perl" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if textjustifier("A", 7) == "***A***" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if textjustifier("", 5) == "*****" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

