#! /usr/bin/lua

function h_index(c0)
   local c = c0
   table.sort(c, function(a, b) return b < a end)
   local h = 0
   for i, x in ipairs(c) do
      if i <= x then
         h = i
      else
         break
      end
   end
   return h
end

if h_index({10, 8, 5, 4, 3}) == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if h_index({25, 8, 5, 3, 3}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

