#!/usr/bin/env lua

-- run <script> <file 1st-line-nr 2nd-line-nr>

function lnRng(pth,l1,l2)
   local ix,lns=0,{}
   for l in io.lines(pth) do
      ix=ix+1
      if ix>=l1 and ix<=l2 then table.insert(lns,l) end
   end
   return lns
end

for _,l in ipairs(lnRng(arg[1],tonumber(arg[2]),tonumber(arg[3]))) do
   print(l)
end
