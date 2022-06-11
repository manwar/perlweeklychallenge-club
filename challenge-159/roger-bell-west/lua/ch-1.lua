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

function gcd(m0,n0)
   local m,n = m0,n0
   while n ~= 0 do
      m,n = n,m % n
   end
   return m
end

function lcm(m,n)
   return m/gcd(m,n)*n
end

function lcmseries(a,b)
   local t=1
   for v = a,b do
      t = lcm(t,v)
   end
   return t
end

function farey(n)
   local l=lcmseries(2,n)
   local d={}
   local s={}
   for i = 1,n do
      local m = l / i
      for j = 0,i do
         local k = m * j
         if d[k] == nil then
            d[k] = {j,i}
            table.insert(s,k)
         end
      end
   end
   table.sort(s)
   local out={}
   for k,v in ipairs(s) do
      table.insert(out,d[v])
   end
   return out
end

if recursive_compare(farey(5),{
                        {0, 1}, {1, 5}, {1, 4}, {1, 3}, {2, 5},
                        {1, 2}, {3, 5}, {2, 3}, {3, 4}, {4, 5},
                        {1, 1}
                    }) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if recursive_compare(farey(7),{
                        {0, 1}, {1, 7}, {1, 6}, {1, 5}, {1, 4},
                        {2, 7}, {1, 3}, {2, 5}, {3, 7}, {1, 2},
                        {4, 7}, {3, 5}, {2, 3}, {5, 7}, {3, 4},
                        {4, 5}, {5, 6}, {6, 7}, {1, 1}
                    }) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if recursive_compare(farey(4),{
                        {0, 1}, {1, 4}, {1, 3}, {1, 2}, {2, 3},
                        {3, 4}, {1, 1}
                    }) then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
