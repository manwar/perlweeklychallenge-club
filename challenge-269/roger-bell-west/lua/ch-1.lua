#! /usr/bin/lua

function bitwiseor(a)
   local count = 0
   for i, v in ipairs(a) do
      if v % 2 == 0 then
         count = count + 1
         if count >= 2 then
            return true
         end
      end
   end
   return false
end


if bitwiseor({1, 2, 3, 4, 5}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if bitwiseor({2, 3, 8, 16}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not bitwiseor({1, 2, 5, 7, 9}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

