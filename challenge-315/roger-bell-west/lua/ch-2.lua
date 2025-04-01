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

function findthird(s, a, b)
   local ss = {}
   local sa = ""
   for _, c in ipairs(split(s)) do
      if string.match(c, "%a") ~= nil then
         sa = sa .. c
      else
         if #sa > 0 then
            table.insert(ss, sa)
            sa = ""
         end
      end
   end
   if #sa > 0 then
      table.insert(ss, sa)
   end
   local out = {}
   for i = 0, #ss - 2 do
      if ss[i] == a and ss[i + 1] == b then
         table.insert(out, ss[i + 2])
      end
   end
   return out
end

if recursive_compare(findthird("Perl is a my favourite language but Python is my favourite too.", "my", "favourite"), {"language", "too"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(findthird("Barbie is a beautiful doll also also a beautiful princess.", "a", "beautiful"), {"doll", "princess"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(findthird("we will we will rock you rock you.", "we", "will"), {"we", "rock"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

