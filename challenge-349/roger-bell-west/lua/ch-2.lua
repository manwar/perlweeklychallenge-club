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

function defget(m, v)
   local p = m[v]
   if p == nil then
      p = 0
   end
   return p
end

function meetingpoint(a)
   local c = counterify(split(a))
   return defget(c, "U") == defget(c, "D") and defget(c, "L") == defget(c, "R")
end

if not meetingpoint("ULD") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if meetingpoint("ULDR") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not meetingpoint("UUURRRDDD") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if meetingpoint("UURRRDDLLL") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not meetingpoint("RRUULLDDRRUU") then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

