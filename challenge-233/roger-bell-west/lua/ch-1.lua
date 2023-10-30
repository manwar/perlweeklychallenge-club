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

function similarwords(a)
   local ct = {}
   local ac = string.byte("a")
   for _i, w in ipairs(a) do
      local hs = {}
      for _j, cx in ipairs(split(w)) do
         hs[cx] = true
      end
      local mask = 0
      for c, _j in pairs(hs) do
         mask = mask | (1 << (string.byte(c) - ac))
      end
      if ct[mask] == nil then
         ct[mask] = 1
      else
         ct[mask] = ct[mask] + 1
      end
   end
   local pairc = 0
   for _i, cv in pairs(ct) do
      if cv > 1 then
         pairc = pairc + cv * (cv - 1) / 2
      end
   end
   return pairc
end

if similarwords({"aba", "aabb", "abcd", "bac", "aabc"}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if similarwords({"aabb", "ab", "ba"}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if similarwords({"nba", "cba", "dba"}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

