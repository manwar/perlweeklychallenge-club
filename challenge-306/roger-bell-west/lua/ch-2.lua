#! /usr/bin/lua

function lastelement(a)
   local b = a
   while true do
      table.sort(b)
      local f = table.remove(b, #b)
      local s = table.remove(b, #b)
      if f > s then
         table.insert(b, f - s)
      end
      if #b == 0 then
         return 0
      end
      if #b == 1 then
         return b[1]
      end
   end
end

if lastelement({3, 8, 5, 2, 9, 2}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if lastelement({3, 2, 5}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

