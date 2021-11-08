#!/usr/bin/env lua

-- run <script> <file>

local t={ln=0}

function sorted(w)
   local wt={}
   for i in w:gmatch(".") do table.insert(wt,i) end
   table.sort(wt)
   return w==table.concat(wt)
end

for l in io.lines(arg[1]) do
   local w = l:match("%w+")
   if sorted(w:lower()) and w:len() >= t['ln'] then
      if w:len() > t['ln'] then t={ln=w:len()} end
      table.insert(t,w)
   end
end

for _,v in ipairs(t) do
   print(v)
end
