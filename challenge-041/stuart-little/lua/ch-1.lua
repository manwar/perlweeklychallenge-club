#!/usr/bin/env lua

-- run <script> <number of attractive numbers to see>

function isPrime(n)
   if n<2 then return false end
   for d=2,math.sqrt(n) do
      if n%d==0 then return false end
   end
   return true
end

function prFact(n)
   local factStr=io.popen(("factor %d"):format(n)):read():match(":%s+(.*)")
   local facts={}
   for fact in factStr:gmatch("(%S+)") do
      table.insert(facts,tonumber(fact))
   end
   return facts
end

function isAtt(n)
   return isPrime(#(prFact(n)))
end

local run,nr=2,0
while nr<tonumber(arg[1]) do
   if isAtt(run) then
      print(run)
      nr=nr+1
   end
   run=run+1
end
