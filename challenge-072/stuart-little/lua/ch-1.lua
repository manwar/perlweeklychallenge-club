#!/usr/bin/env lua

-- run <script> <number>

function factExp(n,p)
   local s,frct=0,n/p
   while frct >= 1 do
      s=s+math.floor(frct)
      frct=frct/p
   end
   return s
end

print(math.min(factExp(arg[1],2),factExp(arg[1],5)))
