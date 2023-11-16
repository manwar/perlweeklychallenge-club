#! /usr/bin/lua

function floorsum(a)
   local n = 0
   for _i, iv in ipairs(a) do
      for _j, jv in ipairs(a) do
         n = n + math.floor(iv / jv)
      end
   end
   return n
end

if floorsum({2, 5, 9}) == 10 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if floorsum({7, 7, 7, 7, 7, 7, 7}) == 49 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

