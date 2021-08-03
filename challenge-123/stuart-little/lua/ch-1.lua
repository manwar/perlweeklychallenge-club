#!/usr/bin/env lua

-- run <script> <number $n> to return the first $n ugly numbers

local memo = {[1]=1,[2]=1,[3]=1,[5]=1}

function smth5p(n)
   if memo[n] then return true end
   for _,prm in ipairs({2,3,5}) do
      if n % prm == 0 and memo[n/prm] then
	 memo[n]=1
	 return true
      end
   end
   return false
end

local count,nr=0,0
while (count < tonumber(arg[1])) do
   nr=nr+1
   if smth5p(nr) then
      count=count+1
      print(nr)
   end
end
