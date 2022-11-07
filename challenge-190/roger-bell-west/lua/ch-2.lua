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

function decodedlist(s)
   local stack = {{s}}
   local out = {}
   while true do
      local ent = table.remove(stack, 1)
      local tail = table.remove(ent)
      if string.len(tail) == 0 then
         table.insert(out, ent)
      else
         if string.sub(tail, 1, 1) ~= "0" then
            local q = {}
            for j,k in ipairs(ent) do
               table.insert(q,k)
            end
            table.insert(q, string.sub(tail, 1, 1))
            table.insert(q, string.sub(tail, 2))
            table.insert(stack, q)
         end
         if string.len(tail) >= 2 then
            local v = 0 + string.sub(tail, 1, 2)
            if v >= 1 and v <= 26 then
               local q = {}
               for j,k in ipairs(ent) do
                  table.insert(q,k)
               end
               table.insert(q, v)
               table.insert(q, string.sub(tail, 3))
               table.insert(stack, q)
            end
         end
      end
      if #stack == 0 then
         break
      end
   end
   local k = {}
   alphazero = string.byte("A") - 1
   for i, x in ipairs(out) do
      local ss = ""
      for ii, sc in ipairs(x) do
         ss = ss .. string.char(alphazero + sc)
      end
      table.insert(k, ss)
   end
   table.sort(k)
   return k
end

if recursive_compare(decodedlist("11"), {"AA", "K"}) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if recursive_compare(decodedlist("1115"), {"AAAE", "AAO", "AKE", "KAE", "KO"}) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if recursive_compare(decodedlist("127"), {"ABG", "LG"}) then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
