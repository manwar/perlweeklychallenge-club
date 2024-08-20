#! /usr/bin/lua

function digitcountvalue(a)
   local c = {}
   for ix = 1, #a do
      c[ix - 1] = 0
   end
   for _, n in ipairs(a) do
      if c[n] == nil then
         c[n] = 1
      else
         c[n] = c[n] + 1
      end
   end
   for ix = 1, #a do
      if a[ix] ~= c[ix - 1] then
         return false
      end
   end
   return true
end

if digitcountvalue({1, 2, 1, 0}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not digitcountvalue({0, 3, 0}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

