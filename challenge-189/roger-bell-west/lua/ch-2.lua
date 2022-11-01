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

function arraydegree(a)
   local f = {}
   for dummy, x in ipairs(a) do
      if f[x] == nil then
         f[x] = 1
      else
         f[x] = f[x] + 1
      end
   end
   local degree = math.max(table.unpack(f))
   local inverse = {}
   for i, x in ipairs(a) do
      if inverse[x] == nil then
         inverse[x] = {i, i}
      else
         inverse[x][2] = i
      end
   end
   local minlen = 2 + #a
   local se = {0, 0}
   for n, v in ipairs(f) do
      if v == degree then
         local ll = 1 + inverse[n][2] - inverse[n][1]
         if ll < minlen then
            minlen = ll
            se = inverse[n]
         end
      end
   end
   local out1 = a
   local out2 = {}
   return table.move(out1, se[1], se[2], 1, out2)
end

if recursive_compare(arraydegree({1, 3, 3, 2}), {3, 3}) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if recursive_compare(arraydegree({1, 2, 1, 3}), {1, 2, 1}) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if recursive_compare(arraydegree({1, 3, 2, 1, 2}), {2, 1, 2}) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if recursive_compare(arraydegree({1, 1, 2, 3, 2}), {1, 1}) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if recursive_compare(arraydegree({2, 1, 2, 1, 1}), {1, 2, 1, 1}) then
   io.write("Pass")
else
   io.write("FAIL")
end

print("")
