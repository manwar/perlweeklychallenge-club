#! /usr/bin/lua

function ls(base)
   max=0
   for i = base-1, 0, -1 do
      max = max * base + i
   end
   t=math.floor(math.sqrt(max))
   digits="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
   while true do
      s=t*t
      v=true
      c={}
      for i = 0,base-1 do
         table.insert(c,0)
      end
      dg=""
      while s > 0 do
         d = s % base + 1
         c[d] = c[d] + 1
         if c[d] > 1 then
            v=false
            break
         end
         s=math.floor(s/base)
         dg = string.sub(digits,d,d) .. dg
      end
      if v then
         return dg
      end
      t = t - 1
   end
end

if ls(2) == "1" then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if ls(4) == "3201" then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if ls(10) == "9814072356" then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if ls(12) == "B8750A649321" then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
