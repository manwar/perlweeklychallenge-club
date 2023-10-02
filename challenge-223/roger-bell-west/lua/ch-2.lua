#! /usr/bin/lua

function boxcoins(ints)
   local mx = 0
   local stack = { { ints, 0 } }
   while (#stack > 0) do
      local x = table.remove(stack, #stack)
      local t = x[1]
      local tot = x[2]
      if tot > mx then
         mx = tot
      end
      for i, ti in ipairs(t) do
         local p = ti
         if i > 1 then
            p = p * t[i - 1]
         end
         if i < #t then
            p = p * t[i + 1]
         end
         local stot = tot + p
         local tt = {}
         for ix, tix in ipairs(t) do
            if i ~= ix then
               table.insert(tt, tix)
            end
         end
         table.insert(stack,{tt, stot})
      end
   end
   return mx
end

if boxcoins({3, 1, 5, 8}) == 167 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if boxcoins({1, 5}) == 10 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

