#!/usr/bin/env lua

-- run <script> <space-separated numbers>

function sum(t)
   local s=0
   for _,v in ipairs(t) do s=s+v end
   return s
end

function inOut(tab,mask)
   local sIn,sOut,ix = {},table.pack(table.unpack(tab)),#tab
   while mask > 0 do
      if mask % 2 == 1 then
	 table.insert(sIn,table.remove(sOut,ix))
      end
      mask = mask >> 1
      ix = ix-1
   end
   return sIn, sOut
end

local mn,lOut,rOut = math.huge,{},{}
for i=0,2^(#arg-1) do
   local l,r = inOut(arg,i)
   local val = math.abs(sum(l)-sum(r))
   if #l==math.floor(#arg/2) and val < mn then
      lOut=l
      rOut=r
      mn = val
   end
end

print(table.unpack(lOut))
print(table.unpack(rOut))
