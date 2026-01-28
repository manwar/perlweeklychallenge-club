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

function posmod(x, y)
   local z = x % y
   while z < 0 do
      z = z + y
   end
   return z
end

function rotx(a, offset)
   local o = posmod(offset, 26)
   local base
   if a >= "a" and a <= "z" then
      base = string.byte("a")
   elseif a >= "A" and a <= "Z" then
      base = string.byte("A")
   else
      return a
   end
   local c = posmod(string.byte(a) - base + o, 26) + base
   return string.char(c)
end

function encryptedstring(a, offset)
   local bb = {}
   for _, ch in ipairs(split(a)) do
      table.insert(bb, rotx(ch, offset))
   end
   return join(bb)
end

if encryptedstring("abc", 1) == "bcd" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if encryptedstring("xyz", 2) == "zab" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if encryptedstring("abc", 27) == "bcd" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if encryptedstring("hello", 5) == "mjqqt" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if encryptedstring("perl", 26) == "perl" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

