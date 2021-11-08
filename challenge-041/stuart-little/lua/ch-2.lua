#!/usr/bin/env lua

-- run <script> <number of numbers you want listed>

function showLeo(n)
   if n <= 2 then
      for i=1,n do print(1) end
      os.exit()
   end
   local prev,cur=1,1
   print(prev)
   for i=2,n do
      print(cur)
      local nxt=prev+cur+1
      prev=cur
      cur=nxt
   end
end
showLeo(tonumber(arg[1]))
