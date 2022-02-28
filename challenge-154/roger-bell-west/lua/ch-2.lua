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
   if candidate==2 then
      return true
   elseif candidate==3 then
      return true
   elseif candidate % 2 == 0 then
      return false
   elseif candidate % 3 == 0 then
      return false
   end
   anchor=0
   limit=math.floor(math.sqrt(candidate))
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
   
function padovanprime(ct)
   local cx=ct
   local pp={}
   local padovans={1,1,1}
   while true do
      padovans[4]=padovans[1]+padovans[2]
      padovans[1],padovans[2],padovans[3]=padovans[2],padovans[3],padovans[4]
      if isprime(padovans[3]) then
         if pp[padovans[3]] == nil then
            pp[padovans[3]]=true
            cx = cx - 1
            if cx <= 0 then
               break
            end
         end
      end
   end
   local out={}
   for k,v in pairs(pp) do
      table.insert(out,k)
   end
   table.sort(out)
   return out
end

if recursive_compare(padovanprime(10),
                     {2, 3, 5, 7, 37, 151, 3329, 23833, 13091204281,
                      3093215881333057}) then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
