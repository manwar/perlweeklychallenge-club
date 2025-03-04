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

function upperlower(a)
   local out = ""
   for _i, c in ipairs(split(a)) do
      out = out .. string.char(string.byte(c) ~ 32)
   end
   return out
end   

if upperlower("pERL") == "Perl" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if upperlower("rakU") == "RAKu" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if upperlower("PyThOn") == "pYtHoN" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

