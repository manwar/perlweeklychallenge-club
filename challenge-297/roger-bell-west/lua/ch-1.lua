#! /usr/bin/lua

function contiguousarray(a)
   local lm = (1 + #a) // 2 * 2
   for l = lm, 2, -2 do
      for start = 1, #a - l + 1 do
         local ed = start + l - 1
         local sm = 0
         for i = start, ed do
            sm = sm + a[i]
         end
         if sm * 2 == l then
            return l
         end
      end
   end
   return 0
end

if contiguousarray({1, 0}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if contiguousarray({0, 1, 0}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if contiguousarray({0, 0, 0, 0, 0}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if contiguousarray({0, 1, 0, 0, 1, 0}) == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

