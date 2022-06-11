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

function cardano(ct)
   local out={}
   local k=0
   local cn=0
   while true do
      local a=3*k+2
      local b2c=(k+1)*(k+1)*(8*k+5)
      local b=0
      local b2=0
      local inc=1
      while true do
         b = b + 1
         b2 = b2 + inc
         inc = inc + 2
         if b2 > b2c then
            break
         end
         if b2c % b2 == 0 then
            table.insert(out,{a,b,b2c/b2})
            cn = cn + 1
            if cn >= ct then
               break
            end
         end
      end
      if cn >= ct then
         break
      end
      k = k + 1
   end
   return out
end

if recursive_compare(cardano(5),{{2,1,5},
                        {5,1,52},
                        {5,2,13},
                        {8,1,189},
                        {8,3,21}}) then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
