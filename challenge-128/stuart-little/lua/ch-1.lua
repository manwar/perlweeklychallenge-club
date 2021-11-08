#!/usr/bin/env lua

-- run <script> <space-separated binary words, with one word representing each row>

function mrg(s1,s2)
   local out = ""
   for i=1,s1:len() do
      out = out .. tostring(math.max(tonumber(s1:sub(i,i)), tonumber(s2:sub(i,i))))
   end
   return out
end

function reduce(fn,tab)
   local out = tab[1]
   for i=2,#tab do
      out = fn(out,tab[i])
   end
   return out
end

function maxZeros(s)
   local mx=0
   for seg in string.gmatch(s,"0+") do
      if seg:len() > mx then mx = seg:len() end
   end
   return mx
end

local rows=0
local cols=0

for i=1,#arg do
   for j=i,#arg do
      --print(type(reduce(mrg,table.pack(table.unpack(arg,i,j)))))
      local cl = maxZeros(reduce(mrg,table.pack(table.unpack(arg,i,j))))
      if (j-i+1)*cl > rows*cols then
	 rows, cols = j-i+1, cl
      end
   end
end

for _=1,rows do
   local row=""
   for _=1,cols do row = row .. '0' end
   print(row)
end
