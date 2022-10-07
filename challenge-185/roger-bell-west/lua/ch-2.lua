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

function recomposemaskcode(list)
   local out = {}
   for i, ins in ipairs(list) do
      count = 0
      os = ""
      for c in string.gmatch(ins, ".") do
         if (c >= "0" and c <= "9") or (c >= "a" and c <= "z") then
            if count < 4 then
               count = count + 1
               os = os .. "x"
            else
               os = os .. c
            end
         else
            os = os .. c
         end
      end
      table.insert(out, os)
   end
   return out
end

if (recursive_compare(recomposemaskcode({"ab-cde-123", "123.abc.420",
                                         "3abc-0010.xy"}),
              {"xx-xxe-123", "xxx.xbc.420", "xxxx-0010.xy"  })) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if (recursive_compare(recomposemaskcode({"1234567.a", "a-1234-bc",
                                         "a.b.c.d.e.f"}),
                      { "xxxx567.a", "x-xxx4-bc", "x.x.x.x.e.f" })) then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
