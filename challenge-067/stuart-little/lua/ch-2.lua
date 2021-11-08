#!/usr/bin/env lua

-- run <script> <number>

local dict={
   [0]="0",
   "_@",
   "abc",
   "def",
   "ghi",
   "jkl",
   "mno",
   "pqrs",
   "tuv",
   "wxyz"
}

function poss(dict,w)
   if w:len()==0 then return {""} end
   local prev=poss(dict,w:sub(1,-2))
   local out={}
   for _,wrd in ipairs(prev) do
      for i=1,string.len(dict[tonumber(w:sub(-1))]) do
	 table.insert(out,wrd..dict[tonumber(w:sub(-1))]:sub(i,i))
      end
   end
   return out
end

for _,w in ipairs(poss(dict,arg[1])) do
   print(w)
end
