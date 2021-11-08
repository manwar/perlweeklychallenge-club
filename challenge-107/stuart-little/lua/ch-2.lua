#!/usr/bin/env lua

-- run <script> 

function fns(t)
   local res={}
   for k,v in pairs(t) do
      if type(v)=='function' then
	 res[k]=v
      end
   end
   return res
end

local Class={
   x="var",
   y=1,
   f1=function(x) return x^2 end,
   f2=function(x,y) return x+y end,
}

for k,v in pairs(fns(Class)) do
   print(k,v)
end
