#! /usr/bin/lua

function removeone(a)
   local ec = 0
   local le = 1 + a[2] - a[1]
   for i, s0 in ipairs(a) do
      if i < #a then
         local s1 = a[i + 1]
         if s1 <= s0 then
            ec = ec + 1
            if ec > 1 or (s0 - s1 >= le) then
               return false
            end
         end
         le = s1 - s0
      end
   end
   return true
end

if removeone({0, 2, 9, 4, 6}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not removeone({5, 1, 3, 2}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if removeone({2, 2, 3}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

