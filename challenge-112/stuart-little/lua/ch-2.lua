#!/usr/bin/env lua

-- run <script> <number>

local memo={[0]={{}},{{1}},{{1,1},{2}}}

function pths(n)
   if n >= #memo then
      table.insert(memo,{})
      for i = 1,2 do
	 for _,pth in ipairs(memo[n-i]) do
	    table.insert(memo[n],table.pack(i,table.unpack(pth)))
	 end
      end      
   end
   return memo[n]
end

for i = 3,arg[1] do
   pths(i)
end

for _,pth in ipairs(memo[tonumber(arg[1])]) do
   print(table.unpack(pth))
end
