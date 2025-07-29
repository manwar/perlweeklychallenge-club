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

function counterify(a)
   local cc = {}
   for _, c in ipairs(a) do
      if cc[c] == nil then
         cc[c] = 0
      end
      cc[c] = cc[c] + 1
   end
   return cc
end

function oddletters(a)
   local c = counterify(split(a))
   for _, v in pairs(c) do
      if v % 2 == 0 then
         return false
      end
   end
   return true
end

if not oddletters("weekly") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if oddletters("perl") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not oddletters("challenge") then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

