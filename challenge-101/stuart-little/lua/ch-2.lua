#!/usr/bin/env lua

-- run <script> <x1 y1 x2 y2 x3 y3>

function contains0(t)
   local lt90=0
   local tt = table.pack(table.unpack(t))
   for i=1,2 do table.insert(tt,tt[i]) end
   for i=1,3 do
      local dotP=tt[2*i-1]*tt[2*i+1] + tt[2*i]*tt[2*i+2]
      if dotP > 0 then lt90=lt90+1 end
   end
   return lt90 >= 2 and 0 or 1
end

print(contains0(table.pack(table.unpack(arg,1,6))))
