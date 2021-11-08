#!/usr/bin/env lua

-- run <script> <numerator> <denominator>

require 'luarocks.loader'
local bc = require('bc')

function expIn(n,p)
   local res=0
   while math.abs(n) > 0 do
      if (n % p == 0) then res=res+1 end
      n = n/p
   end
   return res
end

function copr(n,d)
   local smN = n % d
   local exp,base=1, (10%d)
   while ((base-1) % d ~= 0) do
      exp=exp+1
      base = (base*10) % d
   end     
   return math.floor(n/d), ("%0"..exp.."d"):format((smN*(bc.pow(10,exp)-1)/d):tostring())
end

function nonCopr(n,d)
   local sgn = (n < 0) and "-" or "" 
   local smN = math.abs(n) % d
   local exp2,exp5 = expIn(d,2), expIn(d,5)
   local exp10 = math.max(exp2,exp5)
   local smD=math.floor(d/(2^exp2 * 5^exp5))
   local nRep,rep = copr(((exp2 > exp5) and 5^(exp2-exp5) or 2^(exp5-exp2))*smN,smD)
   return sgn, math.floor(math.abs(n)/d), exp10, nRep, rep
end

function fmtFrac(n,d)
   local sgn,int,shift,nRep,rep = nonCopr(tonumber(n),tonumber(d))
   return sgn .. int .. "." .. (nRep==0 and shift==0 and "" or ("%0"..shift.."d"):format(nRep)) .. (rep=="0" and "" or "("..rep..")")
end

print(fmtFrac(arg[1],arg[2]))
