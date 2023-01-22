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


function propersize(t)
   local l=0
   for k,v in pairs(t) do
      l = l + 1
   end
   return l
end

function sevensegment(l)
   local disp = {0x3f, 0x06, 0x5b, 0x4f, 0x66, 0x6d, 0x7d, 0x07, 0x7f, 0x67}
   local v = {}
   if l == 0 then
      v = {0}
   else
      local ll = l
      while ll > 0 do
         table.insert(v, 1, ll % 10)
         ll = ll // 10
      end
   end
   local d = {}
   for r = 1, 7 do
      local s = {}
      for c = 1, 6 * #v do
         table.insert(s, " ")
      end
      table.insert(d, s)
   end
   for i, vv in ipairs(v) do
      local x = 6 * (i - 1) + 1
      local da = disp[vv + 1]
      if da & 1 > 0 then
         for xa = x + 1, x + 3 do
            d[1][xa] = '#'
         end
      end
      if da & 2 > 0 then
         for y = 2, 3 do
            d[y][x + 4] = '#'
         end
      end
      if da & 4 > 0 then
         for y = 5, 6 do
            d[y][x + 4] = '#'
         end
      end
      if da & 8 > 0 then
         for xa = x + 1, x + 3 do
            d[7][xa] = '#'
         end
      end
      if da & 16 > 0 then
         for y = 5, 6 do
            d[y][x] = '#'
         end
      end
      if da & 32 > 0 then
         for y = 2, 3 do
            d[y][x] = '#'
         end
      end
      if da & 64 > 0 then
         for xa = x + 1, x + 3 do
            d[4][xa] = '#'
         end
      end
   end
   for dummy, r in ipairs(d) do
      print(table.concat(r))
   end
end

sevensegment(1234567890)
sevensegment(200)
