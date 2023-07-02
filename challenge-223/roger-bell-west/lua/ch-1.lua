#! /usr/bin/lua

function genprimes(mx)
   local primesh = {}
   for i = 2, math.min(3, mx) do
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

function countprimes(l)
   return #genprimes(l)
end

if countprimes(10) == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if countprimes(1) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if countprimes(20) == 8 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

