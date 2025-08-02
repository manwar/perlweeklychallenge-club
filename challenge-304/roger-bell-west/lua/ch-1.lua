#! /usr/bin/lua

function arrangebinary(a, n)
   local b = a
   local t = n
   for i = 1,#b do
      if b[i] ==0 and
         (i == 1 or b[i - 1] == 0) and
         (i == #b or b[i + 1] == 0) then
         b[i] = 1
         t = t - 1
         if t == 0 then
            break
         end
      end
   end
   return t == 0
end

if arrangebinary({1, 0, 0, 0, 1}, 1) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not arrangebinary({1, 0, 0, 0, 1}, 2) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

