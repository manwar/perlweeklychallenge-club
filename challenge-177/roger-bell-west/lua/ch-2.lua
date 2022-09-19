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

function ppc(ct)
   local o = {}
   local fh = 0
   while #o < ct do
      fh = fh + 1
      local t = fh
      local q = true
      while t > 0 do
         if t % 10 == 0 then
            q = false
            break
         end
         t = math.floor(t / 10)
      end
      if q then
         local sfh = tostring(fh)
         local c = tonumber(sfh .. "0" .. string.reverse(sfh))
         if isprime(c) then
            table.insert(o,c)
            if #o >= ct then
               break
            end
         end
      end
   end
   return o
end

if recursive_compare(
   ppc(20),
   { 101, 16061, 31013, 35053, 38083, 73037, 74047, 91019, 94049,
     1120211, 1150511, 1160611, 1180811, 1190911, 1250521, 1280821,
     1360631, 1390931, 1490941, 1520251 }
) then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
