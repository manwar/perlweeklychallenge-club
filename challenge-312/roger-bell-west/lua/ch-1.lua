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

function transfer(a, b)
   local ac = string.byte(a)
   local bc = string.byte(b)
   return math.min((ac - bc + 26) % 26, (bc - ac + 26) % 26)
end

function minimumtime(a)
   local tot = #a
   local prev = "a"
   for _, c in ipairs(split(a)) do
      tot = tot + transfer(prev, c)
      prev = c
   end
   return tot
end

if minimumtime("abc") == 5 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if minimumtime("bza") == 7 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if minimumtime("zjpc") == 34 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

