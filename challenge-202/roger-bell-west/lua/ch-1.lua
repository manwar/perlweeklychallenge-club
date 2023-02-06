#! /usr/bin/lua

function consecutiveodds(a)
   local i = 0
   for _dummy,v in ipairs(a) do
      if v % 2 == 1 then
         i = i + 1
         if i >= 3 then
            return true
         end
      else
         i = 0
      end
   end
   return 0
end

if consecutiveodds({1, 5, 3, 6}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if ~consecutiveodds({2, 6, 3, 5}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if ~consecutiveodds({1, 2, 3, 4}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if consecutiveodds({2, 3, 5, 7}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

