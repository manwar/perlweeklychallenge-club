#! /usr/bin/lua

function recomposemac(inp)
   local out = ""
   local count = 0
   for c in string.gmatch(inp, ".") do
      if (c >= "0" and c <= "9") or (c >= "a" and c <= "f") then
         if count == 2 then
            out = out .. ":"
            count = 0
         end
         count = count + 1
         out = out .. c
      end
   end
   return out
end

if recomposemac("1ac2.34f0.b1c2") == "1a:c2:34:f0:b1:c2" then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if recomposemac("abc1.20f1.345a") == "ab:c1:20:f1:34:5a" then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
