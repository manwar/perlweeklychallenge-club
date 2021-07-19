#!/usr/bin/env lua

-- run <script> <space-separated array entries>

function dims(n)
   local rows = 1
   for i=1,math.sqrt(n) do
      if n % i == 0 then rows=i end
   end
   return rows, math.floor(n/rows)
end

function rot(t)
   if #t==0 then return {} end
   local rt={}   
   for i=#(t[1]),1,-1 do
      local row={}
      for j=1,#t do table.insert(row,t[j][i]) end
      table.insert(rt,row)
   end
   return rt
end

function spiral(t,rows,cols)
   local sp={}
   if rows*cols==0 then return sp end
   table.insert(sp,table.pack(table.unpack(t,1,cols)))
   local rest = rot(spiral(table.pack(table.unpack(t,cols+1)),cols,rows-1))
   for k,v in ipairs(rest) do
      table.insert(sp,k,v)
   end
   return sp
end

function ppMat(t)
   for _,v in ipairs(t) do print(table.unpack(v)) end
end

local rows,cols=dims(#arg)
ppMat(spiral(arg,rows,cols))
