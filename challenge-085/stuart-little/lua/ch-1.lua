#!/usr/bin/env lua

-- run <script> <space-separated numbers>

local nrs={}
for _,v in ipairs(arg) do
   local nr=tonumber(v)
   if nr<2 then table.insert(nrs,nr) end
end
table.sort(nrs)
for i=1,#nrs-2 do
   for j=i+1,#nrs-1 do
      for k=j+1,#nrs do
	 local s=nrs[i]+nrs[j]+nrs[k]
	 if s>1 and s<2 then
	    print(1)
	    os.exit()
	 end
      end
   end
end
print(0)
