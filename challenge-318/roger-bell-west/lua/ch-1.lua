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

function groupposition(a)
   local mx = {}
   local lc = "z"
   for i, c in ipairs(split(a)) do
      if i == 1 then
         lc = string.char(string.byte(c) + 1)
      end
      if lc == c then
         mx[#mx][2] = mx[#mx][2] + 1
      else
         table.insert(mx, {c, 1})
         lc = c
      end
   end
   local out = {}
   for _, ms in ipairs(mx) do
      if ms[2] >= 3 then
         table.insert(out, string.rep(ms[1], ms[2]))
      end
   end
   return out
end

if recursive_compare(groupposition("abccccd"), {"cccc"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(groupposition("aaabcddddeefff"), {"aaa", "dddd", "fff"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(groupposition("abcdd"), {}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

