#! /usr/bin/lua

function sumbitwise(ls)
   local s = 0
   for i = 1, #ls-1 do
      for j = i+1, #ls do
         s = s + (ls[i] & ls[j])
      end
   end
   return s
end

if sumbitwise({1,2,3}) == 3 then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if sumbitwise({2,3,4}) == 2 then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
