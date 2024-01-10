#! /usr/bin/lua

function concat(a0, b0)
   if b0 == 0 then
      return 10 * a0
   end
   local a = a0
   local b = b0
   while b > 0 do
      a = a * 10
      b = math.floor(b / 10)
   end
   return a + b0
end

function concatenationvalue(a)
   local t = 0
   for i = 1, math.floor((#a + 1) / 2) do
      local j = #a + 1 - i
      if j == i then
         t = t + a[i]
      else
         t = t + concat(a[i], a[j])
      end
   end
   return t
end

if concatenationvalue({6, 12, 25, 1}) == 1286 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if concatenationvalue({10, 7, 31, 5, 2, 2}) == 489 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if concatenationvalue({1, 2, 10}) == 112 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

