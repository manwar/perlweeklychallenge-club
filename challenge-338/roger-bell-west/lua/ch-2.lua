#! /usr/bin/lua

function maxdistance(a, b)
   local l1 = math.min(table.unpack(a))
   local h1 = math.max(table.unpack(a))
   local l2 = math.min(table.unpack(b))
   local h2 = math.max(table.unpack(b))
   return math.max(h1 - l2, h2 - l1)
end

if maxdistance({4, 5, 7}, {9, 1, 3, 4}) == 6 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maxdistance({2, 3, 5, 4}, {3, 2, 5, 5, 8, 7}) == 6 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maxdistance({2, 1, 11, 3}, {2, 5, 10, 2}) == 9 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maxdistance({1, 2, 3}, {3, 2, 1}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maxdistance({1, 0, 2, 3}, {5, 0}) == 5 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

