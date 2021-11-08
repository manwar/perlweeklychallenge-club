#!/usr/bin/env lua

-- run <script> <number>

function gcd(a,b)
   local lg,sml = math.max(math.abs(a),math.abs(b)),math.min(math.abs(a),math.abs(b))
   if sml==0 then return lg end
   return gcd(sml,lg%sml)
end

local sm=0
for i=1,arg[1]-1 do
   for j=i+1,arg[1] do
      sm=sm+gcd(i,j)
   end
end
print(sm)
