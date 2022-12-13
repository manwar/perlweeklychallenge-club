#! /usr/bin/lua

function specialintegers(n)
   local o = 0
   for i = 1, n do
      local f = {}
      local s = true
      for c in string.gmatch(i, ".") do
         if f[c] == nil then
            f[c] = 1
         else
            s = false
            break
         end
      end
      if s then
         o = o + 1
      end
   end
   return o
end

if specialintegers(15) == 14 then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")
if specialintegers(35) == 32 then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
