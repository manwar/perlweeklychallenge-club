#! /usr/bin/lua

-- by hookenz at
-- https://stackoverflow.com/questions/9168058/how-to-dump-a-table-to-console
function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

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

function gcd(m0,n0)
   local m,n = m0,n0
   while n ~= 0 do
      m,n = n,m % n
   end
   return m
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

function achilles(ct)
   local o = {}
   local n = 1
   while true do
      n = n + 1
      local pv = {}
      for k,v in pairs(primefactor(n)) do
         table.insert(pv,v)
      end
      if #pv > 1 then
         if math.min(table.unpack(pv)) >= 2 then
            local g = 0
            for k,v in pairs(pv) do
               if g == 0 then
                  g = v
               else
                  g = gcd(g,v)
               end
            end
            if g == 1 then
               table.insert(o,n)
               if #o >= ct then
                  break
               end
            end
         end
      end
   end
   return o
end

if recursive_compare(achilles(20), {72, 108, 200, 288, 392, 432, 500,
                                    648, 675, 800, 864, 968, 972,
                                    1125, 1152, 1323, 1352, 1372,
                                    1568, 1800}) then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
