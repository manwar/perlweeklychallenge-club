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

function reverseword(a, c)
   local s, e = string.find(a, c, 1, true)
   if s == nil then
      return a
   end
   local b = split(string.sub(a, 1, s))
   table.sort(b)
   for _, ch in ipairs(split(string.sub(a, s+1))) do
      table.insert(b, ch)
   end
   return join(b)
end

if reverseword("challenge", "e") == "acehllnge" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if reverseword("programming", "a") == "agoprrmming" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if reverseword("champion", "b") == "champion" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

