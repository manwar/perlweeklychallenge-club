#!/usr/bin/env lua

-- run <script> <number>

function canSplit(lrg,sml)
   rest = lrg:match(sml .. "(.*)")
   if not rest then
      return nil
   end
   if lrg == sml then
      return lrg
   end
   nextIt = canSplit(rest,("%d"):format(sml+1))
   return nextIt and sml .. ", " .. nextIt or nil
end

for i=1,arg[1]:len() do
   res = canSplit(arg[1],arg[1]:sub(1,i))
   if res then
      print(res)
      os.exit()
   end
end
