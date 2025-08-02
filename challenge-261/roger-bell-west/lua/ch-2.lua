#! /usr/bin/lua

function multiplybytwo(a, start)
   local p = {}
   for _, v in ipairs(a) do
      p[v] = true
   end
   local v = start
   while p[v] ~= nil do
      v = v * 2
   end
   return v
end

if multiplybytwo({5, 3, 6, 1, 12}, 3) == 24 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if multiplybytwo({1, 2, 4, 3}, 1) == 8 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if multiplybytwo({5, 6, 7}, 2) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

