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

function ulam(u,v,count)
  ulams={u,v}
  sieve={}
  uc=v
  while #ulams < count do
    for i = #sieve+1,uc + ulams[#ulams-1] do
      table.insert(sieve,0)
    end
    for i = 1,#ulams-1 do
      j=uc+ulams[i]
      sieve[j] = sieve[j] + 1
    end
    for i = uc+1,#sieve do
      if sieve[i] == 1 then
        uc = i
        table.insert(ulams,uc)
        break
      end
    end
  end
  return ulams
end

if recursive_compare(ulam(1,2,10),{1, 2, 3, 4, 6, 8, 11, 13, 16, 18}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(ulam(2,3,10),{2, 3, 5, 7, 8, 9, 13, 14, 18, 19}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(ulam(2,5,10),{2, 5, 7, 9, 11, 12, 13, 15, 19, 23}) then
  io.write("Pass")
else
  io.write("FAIL")
end

print("")