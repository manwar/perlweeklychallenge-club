#! /usr/bin/lua

function uniqueoccurrences(a)
   local c = {}
   for _, n in ipairs(a) do
      if c[n] == nil then
         c[n] = 1
      else
         c[n] = c[n] + 1
      end
   end
   local s = {}
   for _, v in pairs(c) do
      if s[v] ~= nil then
         return 0
      end
      s[v] = true
   end
   return 1
end

if uniqueoccurrences({1, 2, 2, 1, 1, 3}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if uniqueoccurrences({1, 2, 3}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if uniqueoccurrences({-2, 0, 1, -2, 1, 1, 0, 1, -2, 9}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

