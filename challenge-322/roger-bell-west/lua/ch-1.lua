#! /usr/bin/lua

function filter(seq, func)
   local out = {}
   for _, x in ipairs(seq) do
      if func(x) then
         table.insert(out, x)
      end
   end
   return out
end

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

function formatstring(a, n)
   local p = filter(split(a), function(a) return a ~= "-" end)
   local r = #p % n + 1
   if r == 1 then
      r = r + n
   end
   local o = ""
   for i, c in ipairs(p) do
      if r == i then
         o = o .. "-"
         r = r + n
      end
      o = o .. c
   end
   return o
end

if formatstring("ABC-D-E-F", 3) == "ABC-DEF" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if formatstring("A-BC-D-E", 2) == "A-BC-DE" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if formatstring("-A-B-CD-E", 4) == "A-BCDE" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

