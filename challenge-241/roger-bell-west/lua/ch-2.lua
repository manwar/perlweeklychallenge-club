#! /usr/bin/lua

-- by Michael Anderson at
-- https://stackoverflow.com/questions/8722620/comparing-two-index-tables-by-index-value-in-lua
-- modified by Roger
function recursive_compare(t1,t2)
  -- Use usual comparison first.
  if t1==t2 then return true end
  -- We only support non-default behavior for tables
  if (type(t1)~="table") then return false end
  -- They better have the same metatables
  local mt1 = getmetatable(t1)
  local mt2 = getmetatable(t2)
  if( not recursive_compare(mt1,mt2) ) then return false end
  -- Build list of all keys
  local kk = {}
  for k1, _ in pairs(t1) do
     kk[k1] = true
  end
  for k2, _ in pairs(t2) do
     kk[k2] = true
  end
  -- Check each key that exists in at least one table
  for _, k in ipairs(kk) do
     if (not recursive_compare(t1[k], t2[k])) then
        return false
     end
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

function primefactorcount(n)
   local r = 0
   for k, v in pairs(primefactor(n)) do
      r = r + v
   end
   return r
end

function primeorder(a)
   local b = a
   local c = {}
   for _, v in ipairs(b) do
      if c[v] == nil then
         c[v] = primefactorcount(v)
      end
   end
   table.sort(b, function(a, b)
                 if c[a] == c[b] then
                    return a < b
                 else
                    return c[a] < c[b]
                 end
   end)
   return b
end

if recursive_compare(primeorder({11, 8, 27, 4}), {11, 4, 8, 27}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

