#! /usr/bin/lua

function maxindex(n)
   local mxv = 0
   local mxi = 0
   for i, v in ipairs(n) do
      if i == 1 or v > mxv then
         mxv = v
         mxi = i
      end
   end
   return mxi-1
end

if maxindex({5, 2, 9, 1, 7, 6}) == 2 then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if maxindex({4, 2, 3, 1, 5, 0}) == 4 then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if maxindex({4, 2, 3, 1, 4, 0}) == 0 then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
