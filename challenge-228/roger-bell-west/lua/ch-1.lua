#! /usr/bin/lua

function uniquesum(a)
   local c = {}
   for _, v in ipairs(a) do
      if c[v] == nil then
         c[v] = 1
      else
         c[v] = c[v] + 1
      end
   end
   local t = 0
   for k, v in pairs(c) do
      if v == 1 then
         t = t + k
      end
   end
   return t
end


if uniquesum({2, 1, 3, 2}) == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if uniquesum({1, 1, 1, 1}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if uniquesum({2, 1, 3, 4}) == 10 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

