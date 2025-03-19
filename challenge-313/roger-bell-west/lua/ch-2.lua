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

function reverseletters(a)
   local vout = {}
   local letterslots = {}
   local letters = {}
   for i, c in ipairs(split(a)) do
      if (c >= "a" and c <= "z") or (c >= "A" and c <= "Z") then
         table.insert(letterslots, i)
         table.insert(letters, c)
      else
         vout[i] = c
      end
   end
   for _, i in ipairs(letterslots) do
      vout[i] = table.remove(letters, #letters)
   end
   return join(vout)
end

if reverseletters("p-er?l") == "l-re?p" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if reverseletters("wee-k!L-y") == "yLk-e!e-w" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if reverseletters("_c-!h_all-en!g_e") == "_e-!g_nel-la!h_c" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

