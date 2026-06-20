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

function l2n(a)
   local a0 = string.byte("a")
   local t = 0
   for _, c in ipairs(split(a)) do
      t = t * 10 + string.byte(c) - a0
   end
   return t
end

function sumofwords(a, b, c)
   return l2n(a) + l2n(b) == l2n(c)
end

if sumofwords("acb", "cba", "cdb") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if sumofwords("aab", "aac", "ad") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not sumofwords("bc", "je", "jg") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if sumofwords("a", "aaaa", "aa") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not sumofwords("c", "d", "h") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if sumofwords("gfi", "hbf", "bdhd") then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

