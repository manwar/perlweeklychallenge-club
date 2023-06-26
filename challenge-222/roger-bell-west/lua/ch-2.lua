#! /usr/bin/lua

function lastmember(a0)
   local a = a0
   while #a > 1 do
      table.sort(a)
      local x = table.remove(a, #a)
      local y = table.remove(a, #a)
      if x ~= y then
         table.insert(a, x - y)
      end
   end
   if #a == 0 then
      return 0
   else
      return a[1]
   end
end

if lastmember({2, 7, 4, 1, 8, 1}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if lastmember({1}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if lastmember({1, 1}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

