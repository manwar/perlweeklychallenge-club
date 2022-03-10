#! /usr/bin/lua

function genprimes(mx)
   local primesh = {}
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
   local q={2,3,5,7}
   local p=table.remove(q,1)
   local mr=math.floor(math.sqrt(mx))
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
   local primes = {}
   for k,v in pairs(primesh) do
      table.insert(primes,k)
   end
   table.sort(primes)
   return primes
end

function primefactor(n)
   local f={}
   local m=n
   for k,p in pairs({2,3,5,7}) do
      while m % p == 0 do
         m=math.floor(m/p)
         if f[p] == nil then
            f[p]=1
         else
            f[p] = f[p] + 1
         end
      end
   end
   if m>1 then
      for k,p in pairs(genprimes(m)) do
         while m % p == 0 do
            m=math.floor(m/p)
            if f[p] == nil then
               f[p]=1
            else
               f[p] = f[p] + 1
            end
            if m==1 then
               break
            end
         end
      end
   end
   return f
end

function gcd(m0,n0)
   local m,n = m0,n0
   while n ~= 0 do
      m,n = n,m % n
   end
   return m
end

function lcm(m,n)
   return m/gcd(m,n)*n
end

function pisano(n)
   local a=1
   for k,v in pairs(primefactor(n)) do
      local nn = k ^ v
      local t=1
      local x={1,1}
      while x[1] ~= 0 or x[2] ~= 1 do
         t = t + 1
         x = {x[2],(x[1]+x[2]) % nn}
      end
      a=lcm(a,t)
   end
   return a
end

if pisano(3) == 8 then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if pisano(6) == 24 then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
