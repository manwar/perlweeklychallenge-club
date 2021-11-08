#!/usr/bin/env lua

-- run <script> <number>

memo={{''},{'R','LH'}}
function mkPaths(size)
   if (tonumber(size) >= #memo) then
      res = {}
      for _,v in ipairs(mkPaths(size-1)) do
	 table.insert(res, 'R' .. v)
      end
      for nr = 0,size-1 do
	 lt = mkPaths(nr)
	 rt = mkPaths(size-1-nr)
	 for _,lft in ipairs(lt) do
	    for _,rght in ipairs(rt) do
	       table.insert(res, 'L' .. lft .. 'H' .. rght)
	    end
	 end
      end
      table.insert(memo,res)
   end
   return memo[size+1]
end

for i = 2,arg[1] do
   mkPaths(i)
end

for _,v in ipairs(mkPaths(arg[1])) do
   print(v)
end
