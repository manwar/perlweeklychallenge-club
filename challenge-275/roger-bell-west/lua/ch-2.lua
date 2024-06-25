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

function replacedigits(a)
   local out = {}
   local prev = 0
   for _, c in ipairs(split(a)) do
      if c >= "0" and c <= "9" then
         table.insert(out, string.char(prev + c))
      else
         prev = string.byte(c)
         table.insert(out, c)
      end
   end
   return join(out)
end

if replacedigits("a1c1e1") == "abcdef" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if replacedigits("a1b2c3d4") == "abbdcfdh" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if replacedigits("b2b") == "bdb" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if replacedigits("a16z") == "abgz" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

