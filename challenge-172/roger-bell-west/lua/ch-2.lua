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

function fivenumber(n0)
   local n = {}
   for i,v in ipairs(n0) do
      table.insert(n,v)
   end
   table.sort(n)
   local nl = #n - 1
   local o = {n[1]}
   for quartile = 1,3 do
      local bx = quartile * nl
      local base = math.floor(bx / 4)
      local v = n[base+1]
      if bx % 4 ~= 0 then
         v = (n[base+1] + n[base+2]) / 2
      end
      table.insert(o,v)
   end
   table.insert(o,n[#n])
   return o
end

if recursive_compare(
   fivenumber({0., 0., 1., 2., 63., 61., 27., 13.}),
   {0., 0.5, 7.5, 44., 63.}
) then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
