#!/usr/bin/env lua

-- run <script> <number>

function reflect(st,bt)
   return (bt==1) and (st .. st:sub(1,st:len()-1):reverse()) or (st .. st:reverse())
end

if arg[1]:match("^9+$") then
   print(1 .. ("0"):rep(arg[1]:len()-1) .. 1)
   os.exit()
end

l = arg[1]:len()
hlf1 = arg[1]:sub(1,math.ceil(l/2))
print((reflect(hlf1,l%2) > arg[1]) and reflect(hlf1,l%2) or reflect(("%d"):format(hlf1+1),l%2))
