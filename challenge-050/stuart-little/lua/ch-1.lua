#!/usr/bin/env lua

-- run <script> <interval1-left interval1-right interval2-left interval2-right ...>

function overlap(t1,t2)
   return (t1[1]-t2[2])*(t1[2]-t2[1]) <= 0
end

function merge(t1,t2)
   return {math.min(t1[1],t2[1]), math.max(t1[2],t2[2])}
end

function squash(t)
   for i=1,#t-1 do
      for j=i+1,#t do
	 if overlap(t[i],t[j]) then
	    t[j] = merge(t[i],t[j])
	    t[i]="*"
	    goto continue
	 end
      end
      ::continue::
   end
   for i=#t,1,-1 do
      if type(t[i]) ~= 'table' then table.remove(t,i) end
   end
   return t
end

local ints={}
local run={}
for k,v in ipairs(arg) do
   table.insert(run,tonumber(v))
   if (k%2==0) then
      table.insert(ints,run)
      run={}
   end
end
for _,v in ipairs(squash(ints)) do
   print(("[%s, %s]"):format(v[1],v[2]))
end
