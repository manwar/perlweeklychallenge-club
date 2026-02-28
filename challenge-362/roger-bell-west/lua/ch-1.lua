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

function echochamber(a)
   local out = ""
   for i, c in ipairs(split(a)) do
      out = out .. string.rep(c, i)
   end
   return out
end

if echochamber("abca") == "abbcccaaaa" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if echochamber("xyz") == "xyyzzz" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if echochamber("code") == "coodddeeee" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if echochamber("hello") == "heelllllllooooo" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if echochamber("a") == "a" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

