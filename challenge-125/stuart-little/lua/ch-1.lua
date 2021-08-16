#!/usr/bin/env lua

-- run <script> <number>

function trps(n)
   local triples={}
   for i=1,math.floor((n+1)/2) do
      local sqDif=math.floor(math.sqrt(n^2-i^2))
      if i<n and i^2+sqDif^2==n^2 then table.insert(triples,{i,sqDif,n}) end	 
   end
   for i=1,n-1 do
      if n^2 % i == 0 and i%2 == (math.floor(n^2/i))%2 then
	 local s = math.floor(n^2/i)
	 table.insert(triples,{math.floor((s-i)/2), n, math.floor((s+i)/2)})
      end
   end
   return triples
end

local sol = trps(tonumber(arg[1]))
if #sol>0 then
   for _,v in ipairs(sol) do
      print(table.unpack(v))
   end
   os.exit()
end
print(-1)
