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

function n2tab(n)
   local a = {}
   string.gsub(tostring(n), ".", function(c) table.insert(a,c) end)
   table.sort(a)
   return a
end

function reversible(mx)
   local o = {}
   for n = 1,mx do
      local t = n + tonumber(string.reverse(tostring(n)))
      local q = true
      while t > 0 do
         if t % 2 == 0 then
            q = false
            break
         end
         t = math.floor(t / 10)
      end
      if q then
         table.insert(o,n)
      end
   end
   return o
end

if recursive_compare(
   reversible(99),
   { 10, 12, 14, 16, 18, 21, 23, 25, 27, 30, 32, 34, 36, 41, 43, 45,
     50, 52, 54, 61, 63, 70, 72, 81, 90 }
) then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
