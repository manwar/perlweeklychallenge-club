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

function abundant(n)
   if n==1 then
      return false
   end
   local ff = 1
   local s=math.floor(math.sqrt(n))
   if s * s == n then
      ff = ff + s
      s = s - 1
   end
   for pf = 2,s do
      if n % pf == 0 then
         ff = ff + pf + math.floor(n/pf)
         if ff > n then
            return true
         end
      end
   end
   return false
end

function oddabundant(ct)
   local n = 1
   local o = {}
   while true do
      if abundant(n) then
         table.insert(o,n)
         if #o >= ct then
            break
         end
      end
      n = n + 2
   end
   return o
end

if recursive_compare(oddabundant(20),{945, 1575, 2205, 2835, 3465,
                                      4095, 4725, 5355, 5775, 5985,
                                      6435, 6615, 6825, 7245, 7425,
                                      7875, 8085, 8415, 8505, 8925})
then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
