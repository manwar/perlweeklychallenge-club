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
   for k,p in pairs(genprimes(1+math.floor(math.sqrt(m)))) do
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
   if m>1 then
      if f[m] == nil then
         f[m]=1
      else
         f[m] = f[m] + 1
      end
   end
   return f
end

function homeprime(n0)
   local n = n0
   while true do
      local pfc = 0
      local ns = ""
      local t = primefactor(n)
      local kl = {}
      for k,v in pairs(t) do
         pfc = pfc + v
         table.insert(kl,k)
      end
      table.sort(kl)
      if pfc == 1 then
         break
      end
      for k,v in pairs(kl) do
         for i = 1,t[v] do
            ns = ns .. v
         end
      end
      n = 0 + ns
   end
   return n
end

if homeprime(10) == 773 then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if homeprime(16) == 31636373 then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
