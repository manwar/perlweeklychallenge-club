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

function semiprime(mx)
  mxx = math.tointeger(mx/2)
  primesh = {}
  for i = 2, mxx do
    primesh[i] = true
  end
  p = 2
  while p * p <= mxx do
    if primesh[p] ~= nil then
      for i = p*p,mxx,p do
        primesh[i] = nil
      end
    end
    if p == 2 then
      p = p - 1
    end
    p = p + 2
  end
  primes = {}
  for k,v in pairs(primesh) do
    table.insert(primes,k)
  end
  semiprimesh = {}
  for i = 1,#primes-1 do
    for j = i,#primes do
      t = primes[i]*primes[j]
      if t < mx then
        semiprimesh[t]=true
      else
       break
      end
    end
  end
  semiprimes = {}
  for k,v in pairs(semiprimesh) do
    table.insert(semiprimes,k)
  end
  table.sort(semiprimes)
  return semiprimes
end

if recursive_compare(semiprime(100),{4, 6, 9, 10, 14, 15, 21, 22, 25, 26, 33, 34, 35, 38, 39, 46, 49, 51, 55, 57, 58, 62, 65, 69, 74, 77, 82, 85, 86, 87, 91, 93, 94, 95}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")