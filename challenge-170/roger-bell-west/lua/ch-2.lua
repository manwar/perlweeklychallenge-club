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

function kronecker(a,b)
   local o = {}
   local ax = #a[1]
   local ay = #a
   local bx = #b[1]
   local by = #b
   for y = 0, ay * by - 1 do
      local byi = y % by
      local ayi = math.floor(y / by)
      local row = {}
      for x = 0, ax * bx - 1 do
         local bxi = x % bx
         local axi = math.floor(x / bx)
         table.insert(row,a[ayi+1][axi+1] * b[byi+1][bxi+1])
      end
      table.insert(o,row)
   end
   return o
end

if recursive_compare(kronecker(
                        {{1,2},{3,4}},
                        {{5,6},{7,8}}
                              ),
                     {
                        { 5,  6, 10, 12},
                        { 7,  8, 14, 16},
                        {15, 18, 20, 24},
                        {21, 24, 28, 32}
                     }) then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
