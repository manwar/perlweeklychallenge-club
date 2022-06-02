#! /usr/bin/lua

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

function cyclicpermute(n)
   local ss = n
   local o = {}
   for p = 1,string.len(ss) do
      ss = string.sub(ss,2) .. string.sub(ss,1,1)
      table.insert(o,ss+0)
   end
   return o
end

function circular(mindigits,ct)
   local o = {}
   local base = 1
   for p = 2,mindigits do
      base = base * 10
   end
   while #o < ct do
      local pr = genprimes(base * 10)
      local prs = {}
      for k,q in pairs(pr) do
         prs[q] = true
      end
      for k,cp in pairs(pr) do
         if cp >= base then
            local v = true
            local cpp = cyclicpermute(cp)
            for k2,cpc in pairs(cpp) do
               if prs[cpc] == nil then
                  v = false
                  break
               end
            end
            if v then
               table.insert(o,cp)
               if #o >= ct then
                  break
               end
               for k2,cpc in pairs(cpp) do
                  prs[cpc] = nil
               end               
            end
         end
      end
      base = base * 10
   end
   return o
end

if recursive_compare(cyclicpermute(123), {231, 312, 123}) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if recursive_compare(circular(3,10), {113, 197, 199, 337, 1193, 3779,
                                      11939, 19937, 193939, 199933})
then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
