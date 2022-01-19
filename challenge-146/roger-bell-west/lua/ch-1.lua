#! /usr/bin/lua

function genprimes(mx)
   primesh = {}
   for i = 2, 3 do
      primesh[i] = true
   end
   for i = 6, mx, 6 do
      for j = i-1, i+1, 2 do
         if j <= mx then
            primesh[j]=true
         end
      end
   end
   q={2,3,5,7}
   p=table.remove(q,1)
   mr=math.floor(math.sqrt(mx))
   while p <= mr do
      if primesh[p] ~= nil then
         for i = p*p,mx,p do
            primesh[i] = nil
         end
      end
      if #q < 2 then
         table.insert(q,q[#q]+4)
         table.insert(q,q[#q]+2)
      end
      p=table.remove(q,1)
   end
   primes = {}
   for k,v in pairs(primesh) do
      table.insert(primes,k)
   end
   table.sort(primes)
   return primes
end

function nthprime(n)
   m=15
   if n >= 6 then
      m=1+n*math.log(n*math.log(n))
   end
   primes=genprimes(m)
   return primes[n]
end

if nthprime(10001) == 104743 then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
