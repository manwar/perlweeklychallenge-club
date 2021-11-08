#!/usr/bin/env lua

-- run <script> <time, formatted as hh:mm [am/pm]>

function cvrt(h,m,ap)
   if ap:len() > 0 then
      local hap = (ap:lower()=="am") and (("%02d"):format(tonumber(h)%12)) or (("%02d"):format(12+(tonumber(h)%12)))
      return hap..":"..("%02d"):format(m)
   end
   ap=(tonumber(h)>=12) and " pm" or " am"
   h=((tonumber(h)>12) and h-12) or (tonumber(h)==0 and 12) or h
   return ("%02d"):format(h)..":"..("%02d"):format(m)..ap
end

local h,m,ap=table.concat(arg,""):match("(%d+):(%d+)%s*([a-zA-Z]*)")
print(cvrt(h,m,ap))
