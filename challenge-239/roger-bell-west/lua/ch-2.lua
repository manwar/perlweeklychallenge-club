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

function consistentstrings(a, v)
   local vs = {}
   for _i, c in ipairs(split(v)) do
      vs[c] = true
   end
   local n = 0
   for _ai, s in ipairs(a) do
      local valid = true
      for _si, c in ipairs(split(s)) do
         if vs[c] == nil then
            valid = false
            break
         end
      end
      if valid then
         n = n + 1
      end
   end
   return n
end

if consistentstrings({"ad", "bd", "aaab", "baa", "badab"}, "ab") == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if consistentstrings({"a", "b", "c", "ab", "ac", "bc", "abc"}, "ab") == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if consistentstrings({"cc", "acd", "b", "ba", "bac", "bad", "ac", "d"}, "cad") == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

