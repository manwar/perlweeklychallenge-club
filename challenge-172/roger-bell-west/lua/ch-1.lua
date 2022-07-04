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

function primepartition(n, divs)
   local pl = genprimes(n)
   local p = {{}}
   while #p > 0 do
      local pa = table.remove(p)
      if #pa == divs then
         local sum = 0
         for i,v in ipairs(pa) do
            sum = sum + v
         end
         if sum == n then
            return pa
         end
      else
         local px = {}
         for i,v in ipairs(pa) do
            px[v] = true
         end
         for i,pq in ipairs(pl) do
            if px[pq] == nil then
               local pb = {}
               for j,pk in ipairs(pa) do
                  table.insert(pb,pk)
               end
               table.insert(pb,pq)
               table.insert(p,pb)
            end
         end
      end
   end
   return {n}
end

if recursive_compare(primepartition(18,2), {13, 5}) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if recursive_compare(primepartition(19,3), {11, 5, 3}) then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
