#!/usr/bin/env lua

-- run <script> <number>

for i=2,arg[1] do
   local base = math.floor(math.exp(math.log(arg[1])/i))
   for j=0,1 do
      if (base+j)^i==tonumber(arg[1]) then
	 print(("%d: %d = %d ^ %d"):format(1,arg[1],base+j,i))
	 os.exit()
      end
   end
end
print(0)
