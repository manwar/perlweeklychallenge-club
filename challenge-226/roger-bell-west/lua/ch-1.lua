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
   for k,v in pairs(t) do
      out = out .. v
   end
   return out
end

function shufflestring(st, mp)
   local q = split(st)
   local r = {}
   for i = 1, #q do
      r[mp[i] + 1] = q[i]
   end
   return join(r)
end

if shufflestring("lacelengh", {3, 2, 0, 5, 4, 8, 6, 7, 1}) == "challenge" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if shufflestring("rulepark", {4, 7, 3, 1, 0, 5, 2, 6}) == "perlraku" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

