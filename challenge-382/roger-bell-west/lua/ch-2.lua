#! /usr/bin/lua

-- by Michael Anderson at
-- https://stackoverflow.com/questions/8722620/comparing-two-index-tables-by-index-value-in-lua
-- modified by Roger
function recursive_compare(t1,t2)
  -- Use usual comparison first.
  if t1==t2 then return true end
  -- We only support non-default behavior for tables
  if (type(t1)~="table") then return false end
  -- They better have the same metatables
  local mt1 = getmetatable(t1)
  local mt2 = getmetatable(t2)
  if( not recursive_compare(mt1,mt2) ) then return false end
  -- Build list of all keys
  local kk = {}
  for k1, _ in pairs(t1) do
     kk[k1] = true
  end
  for k2, _ in pairs(t2) do
     kk[k2] = true
  end
  -- Check each key that exists in at least one table
  for _, k in ipairs(kk) do
     if (not recursive_compare(t1[k], t2[k])) then
        return false
     end
  end
  return true
end

function split(t)
   local cl = {}
   string.gsub(t,
               "(.)",
               function(c)
                  table.insert(cl, c)
               end
   )
   return cl
end

function filter(seq, func)
   local out = {}
   for _, x in ipairs(seq) do
      if func(x) then
         table.insert(out, x)
      end
   end
   return out
end

function replacequestionmark(a)
   local template = split(a)
   local q = #(filter(template, function(a) return a == "?" end))
   if q == 0 then
      return {a}
   end
   local out = {}
   for n = 0,(1 << q) do
      local qm = {}
      local nn = n
      while nn > 0 do
         local bit = "1"
         if nn % 2 == 0 then
            bit = "0"
         end
         table.insert(qm, bit)
         nn = nn // 2
      end
      while #qm < q do
         table.insert(qm, "0")
      end
      local entry = ""
      for _, tc in ipairs(template) do
         if tc == "?" then
            entry = entry .. table.remove(qm, #qm)
         else
            entry = entry .. tc
         end
      end
      table.insert(out, entry)
   end
   return out
end

if recursive_compare(replacequestionmark("01??0"), {"01000", "01010", "01100", "01110"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(replacequestionmark("101"), {"101"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(replacequestionmark("???"), {"000", "001", "010", "011", "100", "101", "110", "111"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(replacequestionmark("1?10"), {"1010", "1110"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(replacequestionmark("1?1?0"), {"10100", "10110", "11100", "11110"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

