#! /usr/bin/lua

function uniquenumber(a)
   local c = {}
   for _, n in ipairs(a) do
      if c[n] == nil then
         c[n] = 1
      else
         c[n] = c[n] + 1
      end
   end
   for k, v in pairs(c) do
      if v == 1 then
         return k
      end
   end
   return -1
end

if uniquenumber({3, 3, 1}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if uniquenumber({3, 2, 4, 2, 4}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if uniquenumber({1}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if uniquenumber({4, 3, 1, 1, 1, 4}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

