#!/usr/bin/env lua

-- run <script> <score>

function comp(nr,bd)
   local tab={{{},},}
   for n=1,nr do
      local item={}
      for i=1,bd do
	 if (#tab >= i) then
	    for _,v in ipairs(tab[#tab-i+1]) do
	       local vv = table.pack(table.unpack(v))
	       table.insert(vv,1,i)
	       table.insert(item,vv)
	    end
	 end
      end
      if (#tab >= bd) then table.remove(tab,1) end
      table.insert(tab,item)
   end
   return tab[#tab]
end

for _,v in ipairs(comp(tonumber(arg[1]),3)) do
   print(table.unpack(v))
end
