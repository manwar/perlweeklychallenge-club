#!/usr/bin/env lua

-- run <script> <space-separated numbers>

function histo(t)
   local mx = math.max(table.unpack(t))
   local h={}
   for i=0,mx-1 do
      local row={}
      for k,v in ipairs(t) do
	 table.insert(row,v < mx-i and " " or "#")
      end
      table.insert(h,row)
   end
   return h
end

function rain(t)
   local q=0
   for k,v in ipairs(t) do
      if k > 1 and k < #t then
	 local l = math.max(table.unpack(t,1,k-1))
	 local r = math.max(table.unpack(t,k+1))
	 local m = math.min(l,r)
	 q=q+math.max(0,m-v)
      end
   end
   return q
end

local nums={}
for _,nr in ipairs(arg) do table.insert(nums,tonumber(nr)) end
for _,row in ipairs(histo(nums)) do print(table.unpack(row)) end
print(("-"):rep(20))
print(rain(nums))
