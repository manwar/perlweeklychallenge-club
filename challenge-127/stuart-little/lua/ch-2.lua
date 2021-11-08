#!/usr/bin/env lua

-- run <script> <left1 right1 left2 right2 ...>

local sol={}

for j=1,math.floor(#arg/2)-1 do
   for i=0,j-1 do
      if ((arg[2*j+2]-arg[2*i+1])*(arg[2*j+1]-arg[2*i+2]) <= 0) then
	 table.insert(sol, {arg[2*j+1],arg[2*j+2]})
	 goto continue
      end      
   end
   ::continue::
end

for _,v in ipairs(sol) do
   print(table.unpack(v))
end

