#!/usr/bin/env lua

-- run <script> <space-separated numbers>

function egMult(a,b)
   local l,r,p=math.min(a,b),math.max(a,b),0
   while l>0 do
      if l%2==1 then p=p+r end
      l=math.floor(l/2)
      r=r*2
   end
   return p
end

print(("%d"):format(egMult(0+arg[1],0+arg[2])))
