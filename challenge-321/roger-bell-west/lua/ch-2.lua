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

function backspacecompare(a, b)
   local sa = {}
   for _, i in ipairs({a, b}) do
      local oa = {}
      for _n, c in ipairs(split(i)) do
         if c == "#" then
            table.remove(oa, #oa)
         else
            table.insert(oa, c)
         end
      end
      table.insert(sa, join(oa))
   end
   return sa[1] == sa[2]
end

if backspacecompare("ab#c", "ad#c") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if backspacecompare("ab##", "a#b#") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not backspacecompare("a#b", "c") then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

