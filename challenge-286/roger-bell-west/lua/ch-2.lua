#! /usr/bin/lua

function windowed(a, n)
   local out = {}
   for i = 1, #a - n + 1 do
      local t = {}
      for j = i, i + n - 1 do
         table.insert(t, a[j])
      end
      table.insert(out, t)
   end
   return out
end

function ordergame(a)
   local p = a
   while #p > 1 do
      local q = {}
      local mm = true
      for _, j in ipairs(windowed(p, 2)) do
         if mm then
            table.insert(q, math.min(table.unpack(j)))
         else
            table.insert(q, math.max(table.unpack(j)))
         end
         mm = not mm
      end
      p = q
   end
   return p[1]
end

if ordergame({2, 1, 4, 5, 6, 3, 0, 2}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if ordergame({0, 5, 3, 2}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if ordergame({9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

