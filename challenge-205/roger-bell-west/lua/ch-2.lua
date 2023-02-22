#! /usr/bin/lua

function maximumxor(l)
   local m = {}
   for ai = 1,#l - 1 do
      for bi = ai + 1,#l do
         table.insert(m, l[ai] ~ l[bi])
      end
   end
   return math.max(table.unpack(m))
end

if maximumxor({1, 2, 3, 4, 5, 6, 7}) == 7 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maximumxor({2, 4, 1, 3}) == 7 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maximumxor({10, 5, 7, 12, 8}) == 15 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

