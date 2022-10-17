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

function magicaltriplets(a)
   local out = {}
   local mv = 0
   for ai = 1,#a-2 do
      for bi = ai+1,#a-1 do
         for ci = bi+1,#a do
            if a[ai] + a[bi] > a[ci] and
               a[bi] + a[ci] > a[ai] and
               a[ai] + a[ci] > a[bi] then
               local v = a[ai] + a[bi] + a[ci]
               if v > mv then
                  mv = v
                  out = {a[ai], a[bi], a[ci]}
               end
            end
         end
      end
   end
   table.sort(out, function (i,j) return j < i end)
   return out
end

if (recursive_compare(magicaltriplets({1, 2, 3, 2}),
                      {3, 2, 2})) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if (recursive_compare(magicaltriplets({1, 3, 2}),
                      {})) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if (recursive_compare(magicaltriplets({1, 1, 2, 3}),
                      {})) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if (recursive_compare(magicaltriplets({2, 4, 3}),
                      {4, 3, 2})) then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
