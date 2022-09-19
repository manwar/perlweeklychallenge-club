#! /usr/bin/lua

-- by hookenz at
-- https://stackoverflow.com/questions/9168058/how-to-dump-a-table-to-console
function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

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

function ssd(n0)
   local n = n0
   local out = 0
   while n > 0 do
      local d = n % 10
      out = out + d * d
      n = math.floor(n/10)
   end
   return out
end

function happy(ct)
   local hm = {[1] = true}
   local c =0
   local out = {}
   while true do
      c = c + 1
      if hm[c] == nil then
         local v = c
         local ss = {[v] = true}
         local h = true
         while true do
            if hm[v] ~= nil then
               h = hm[v]
               break
            else
               v = ssd(v)
               if ss[v] ~= nil then
                  h = false
                  break
               end
               ss[v] = true
            end
         end
         for k,v in pairs(ss) do
            hm[k] = h
         end
      end
      if hm[c] then
         table.insert(out,c)
         if #out >= ct then
            break
         end
      end
   end
   return out
end

if recursive_compare(happy(8),{1, 7, 10, 13, 19, 23, 28, 31}) then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
