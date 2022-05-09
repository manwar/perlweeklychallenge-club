#! /usr/bin/lua

function summation(ls0)
   local ls = ls0
   while #ls > 1 do
      local lv = {}
      for i = 2, #ls do
         local s = 0
         for j = 2, i do
            s = s + ls[j]
         end
         table.insert(lv,s)
      end
      ls = lv
   end
   return ls[1]
end

if summation({1,2,3,4,5}) == 42 then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if summation({1,3,5,7,9}) == 70 then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
