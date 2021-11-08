#!/usr/bin/env lua

-- run <script> <space-separated numbers, with the window size first>

function slide(fn,t,k)
   local out={}
   for i=1,#t-k+1 do
      table.insert(out,fn(table.unpack(t,i,i+k-1)))
   end
   return out
end

function map(fn,t)
   local out={}
   for _,v in ipairs(t) do
      table.insert(out,fn(v))
   end
   return out
end

print(table.unpack(slide(math.min,map(tonumber,table.pack(table.unpack(arg,2))),tonumber(arg[1]))))
