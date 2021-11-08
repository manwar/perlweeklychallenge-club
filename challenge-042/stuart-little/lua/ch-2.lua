#!/usr/bin/env lua

-- run <script> <string or nothing to default to a random one>

function bal(s)
   local stk={}
   for i=1,s:len() do
      if #stk>0 and stk[#stk]=='(' and s:sub(i,i)==')'
      then table.remove(stk)	 
      else table.insert(stk,s:sub(i,i))
      end
   end
   return (#stk==0) and 'OK' or 'NOT OK'
end

function genRndPars(n)
   local s=""
   for i=1,math.random(n) do
      s=s..math.random(0,1)
   end
   return s:gsub(".",{['0']='(', ['1']=')'})
end

local s=#arg>0 and arg[1] or genRndPars(10)
print(("Your string: %s"):format(s))
print(bal(s))
