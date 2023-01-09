#! /usr/bin/lua

function goodpairs(l)
   local c = 0
   local k = {}
   for dummy, i in ipairs(l) do
      if k[i] == nil then
         k[i] = 1
      else
         k[i] = k[i] + 1
      end
   end
   for dummy, v in ipairs(k) do
      c = c + v * (v - 1)
   end
   return c / 2
end

if goodpairs({1, 2, 3, 1, 1, 3}) == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if goodpairs({1, 2, 3}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if goodpairs({1, 1, 1, 1}) == 6 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

