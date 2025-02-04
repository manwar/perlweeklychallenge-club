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

function findanagrams(a)
   local b = {}
   for _, s in ipairs(a) do
      c = split(s)
      table.sort(c)
      table.insert(b, join(c))
   end
   local out = 1
   for i = 2, #a do
      if b[i - 1] ~= b[i] then
         out = out + 1
      end
   end
   return out
end

if findanagrams({"acca", "dog", "god", "perl", "repl"}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if findanagrams({"abba", "baba", "aabb", "ab", "ab"}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

