#! /usr/bin/lua

function monotonicarray(l)
   local d = {}
   for i = 1, #l - 1 do
      table.insert(d, l[i + 1] - l[i])
   end
   return math.min(table.unpack(d)) * math.max(table.unpack(d)) >= 0
end

if monotonicarray({1, 2, 2, 3}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not monotonicarray({1, 3, 2}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if monotonicarray({6, 5, 5, 4}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

