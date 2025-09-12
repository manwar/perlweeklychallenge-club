#! /usr/bin/lua

function highestrow(a)
   local ms = {}
   for _, x in ipairs(a) do
      local s = 0
      for __, y in ipairs(x) do
         s = s + y
      end
      table.insert(ms, s)
   end
   return math.max(table.unpack(ms))
end

if highestrow({{4, 4, 4, 4}, {10, 0, 0, 0}, {2, 2, 2, 9}}) == 16 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if highestrow({{1, 5}, {7, 3}, {3, 5}}) == 10 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if highestrow({{1, 2, 3}, {3, 2, 1}}) == 6 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if highestrow({{2, 8, 7}, {7, 1, 3}, {1, 9, 5}}) == 17 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if highestrow({{10, 20, 30}, {5, 5, 5}, {0, 100, 0}, {25, 25, 25}}) == 100 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

