#! /usr/bin/lua

function jumpgame(a)
   local target = #a
   local here = {}
   here[1] = true
   local moves = 0
   while true do
      moves = moves + 1
      local there = {}
      for n, _ in pairs(here) do
         for i = n + 1, math.min(n + a[n], target) do
            there[i] = true
         end
      end
      local empty = true
      for k, v in pairs(there) do
         empty = false
         break
      end
      if empty then
         return -1
      end
      if there[target] ~= nil then
         return moves
      end
      here = there
   end
end

if jumpgame({2, 3, 1, 1, 4}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if jumpgame({2, 3, 0, 4}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if jumpgame({2, 0, 0, 4}) == -1 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

