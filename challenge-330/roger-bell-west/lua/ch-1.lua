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

function cleardigits(a)
   local out = {}
   for _, c in ipairs(split(a)) do
      if c >= "0" and c <= "9" then
         table.remove(out, #out)
      else
         table.insert(out, c)
         end
   end
   return join(out)
end

if cleardigits("cab12") == "c" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if cleardigits("xy99") == "" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if cleardigits("pa1erl") == "perl" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

