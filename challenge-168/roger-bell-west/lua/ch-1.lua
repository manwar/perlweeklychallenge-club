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

function isprime(candidate)
   if candidate<2 then
      return false
   elseif candidate==2 then
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

function hammingweight(x0)
   local x = x0
   local count = 0
   while x > 0 do
      x = x & (x-1)
      count = count + 1
   end
   return count
end

function perrinprime(n)
   local out={}
   local ol = 0
   local seq = {3, 0, 2}
   while true do
      local nv = seq[1] + seq[2]
      seq[1] = seq[2]
      seq[2] = seq[3]
      seq[3] = nv
      if isprime(nv) then
         if out[nv] == nil then
            ol = ol + 1
         end
         out[nv] = true
         if ol >= n then
            break
         end
      end
   end
   local o = {}
   for k,v in pairs(out) do
      table.insert(o,k)
   end
   table.sort(o)
   return o
end

if recursive_compare(perrinprime(13), {2, 3, 5, 7, 17, 29, 277, 367,
                                       853, 14197, 43721, 1442968193,
                                       792606555396977}) then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
