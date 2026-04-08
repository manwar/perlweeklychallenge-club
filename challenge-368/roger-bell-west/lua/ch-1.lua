#! /usr/bin/lua

function makeitbigger(st, ch)
   local nv = {}
   local c = string.find(st, ch, 1, true)
   while c ~= nil do
      local o = ""
      if c > 1 then
         o = o .. string.sub(st, 1, c - 1)
      end
      if c < #st then
         o = o .. string.sub(st, c + 1)
      end
      table.insert(nv, 0 + o)
      c = string.find(st, ch, c + 1, true)
   end
   return tostring(math.floor(math.max(table.unpack(nv))))
end

if makeitbigger("15456", "5") == "1546" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if makeitbigger("7332", "3") == "732" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if makeitbigger("2231", "2") == "231" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if makeitbigger("543251", "5") == "54321" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if makeitbigger("1921", "1") == "921" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

