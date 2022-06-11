#! /usr/bin/lua

-- by Michael Anderson at
-- https://stackoverflow.com/questions/8722620/comparing-two-index-tables-by-index-value-in-lua
function recursive_compare(t1,t2)
  -- Use usual comparison first.
  if t1==t2 then return true end
  -- We only support non-default behavior for tables
  if (type(t1)~="table") then return false end
  -- They better have the same metatables
  local mt1 = getmetatable(t1)
  local mt2 = getmetatable(t2)
  if( not recursive_compare(mt1,mt2) ) then return false end

  -- Check each key-value pair
  -- We have to do this both ways in case we miss some.
  -- TODO: Could probably be smarter and not check those we've 
  -- already checked though!
  for k1,v1 in pairs(t1) do
    local v2 = t2[k1]
    if( not recursive_compare(v1,v2) ) then return false end
  end
  for k2,v2 in pairs(t2) do
    local v1 = t1[k2]
    if( not recursive_compare(v1,v2) ) then return false end
  end

  return true  
end

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

function nthprimelimit(n)
   local m=15
   if n >= 6 then
      m=1+n*math.log(n*math.log(n))
   end
   return m
end

function isprime(candidate)
   if candidate==2 then
      return true
   elseif candidate==3 then
      return true
   elseif candidate % 2 == 0 then
      return false
   elseif candidate % 3 == 0 then
      return false
   end
   local anchor=0
   local limit=math.floor(math.sqrt(candidate))
   while true do
      anchor = anchor + 6
      for t = anchor-1,anchor+1,2 do
         if t > limit then
            return true
         end
         if candidate % t == 0 then
            return false
         end
      end
   end
end

function fortunate(ct)
   local o={}
   local ll={}
   local ph=1
   for k,p in pairs(genprimes(nthprimelimit(ct*2))) do
      local leno=0
      local maxo=0
      for kl,pl in pairs(o) do
         leno=leno+1
         if kl > maxo then
            maxo=kl
         end
      end
      if leno >= ct then
         if p >= maxo then
            break
         end
      end
      ph = ph * p
      l = p + 1
      while (not isprime(l+ph)) do
         l = l + 1
      end
      o[l] = true
      leno=0
      for kl,pl in pairs(o) do
         leno=leno+1
      end
      if leno > ct then
         ll = {}
         for kk,v in pairs(o) do
            table.insert(ll,kk)
         end
         table.sort(ll)
         while #ll > ct do
            table.remove(ll,#ll)
         end
         o = {}
         for kx,v in pairs(ll) do
            o[v] = true
         end
      end
   end
   return ll
end

if recursive_compare(fortunate(8), {3, 5, 7, 13, 17, 19, 23, 37}) then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
