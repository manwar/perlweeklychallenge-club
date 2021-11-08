#!/usr/bin/env lua

-- run <script> <m n> to get n-number combos from 1..m

function comb(t)
   local row={[0]={{}}}
   for i=1,#t do
      local tempRow={[0]={{}}}
      for k=1,i do
	 local item={}
	 if (row[k]) then
	    for ix=1,#(row[k]) do
	       table.insert(item,row[k][ix])
	    end
	 end
	 for ixx=1,#(row[k-1]) do
	    local old=table.pack(table.unpack(row[k-1][ixx]))
	    table.insert(old,t[i])
	    table.insert(item,old)
	 end
	 table.insert(tempRow,item)
      end
      row=tempRow
   end
   return row
end

local t={}
for i=1,arg[1] do
   table.insert(t,i)
end

for _,v in ipairs(comb(t)[tonumber(arg[2])]) do
   print(table.unpack(v))
end
