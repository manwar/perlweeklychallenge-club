#!/usr/bin/env lua

-- run <script>

function nbrs(mat,i,j)
   local t={}
   for _,x in ipairs({-1,0,1}) do
      for _,y in ipairs({-1,0,1}) do
	 if ((x ~= 0 or y ~= 0) and 1 <= i+x and i+x <= #mat and 1 <= j+y and j+y <= #(mat[1])) then table.insert(t,{i+x,j+y}) end	    
      end
   end
   return t
end

local inptStr=[[x * * * x * x x x x
* * * * * * * * * x
* * * * x * x * x *
* * * x x * * * * *
x * * * x * * * * x
]]

local inpt={}
for ln in inptStr:gmatch("([^\n]+)") do
   local lnTab = {}
   for chr in ln:gmatch("([^%s]+)") do table.insert(lnTab,chr) end
   table.insert(inpt,lnTab)
end

for i=1,#inpt do
   local ln=""
   for j=1,#(inpt[1]) do
      if inpt[i][j] == 'x' then
	 ln = ln .. 'x' .. ' '
      else
	 local nr=0
	 for _,v in ipairs(nbrs(inpt,i,j)) do
	    if inpt[v[1]][v[2]] == 'x' then nr = nr + 1 end
	 end
	 ln = ln .. tostring(nr) .. " "
      end
   end
   print(ln)
end
