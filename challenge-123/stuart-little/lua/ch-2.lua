#!/usr/bin/env lua

-- run <script> <x1 y1 x2 y2 ..>

function sqDist(coords)
    return (coords[3]-coords[1])^2 + (coords[4]-coords[2])^2
end

function sqDistHash(coords)
   local t={}
   for i=1,3 do
      for j=i+1,4 do
	 local d=sqDist({coords[2*i-1],coords[2*i],coords[2*j-1],coords[2*j]})
	 t[d] = t[d] and t[d]+1 or 1
      end
   end
   return t
end

function isSq(coords)
   local records=0
   for k,v in pairs(sqDistHash(coords)) do
      if k==0 then return false end
      if v==2 or v==4 then records=records+1 end
   end
   return records==2
end

print(isSq(table.pack(table.unpack(arg,1,8))) and 1 or 0)
