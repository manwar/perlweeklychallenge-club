#! /usr/bin/lua

function commoncharacters(a)
   local mc = {}
   for sn, s in ipairs(a) do
      local mk = counterify(split(s))
      if sn == 1 then
         mc = mk
      else
         for k, _v in pairs(mc) do
            if mk[k] ~= nil then
               mc[k] = math.min(mc[k], mk[k])
            else
               mc[k] = nil
            end
         end
      end
   end
   local out = {}
   local kl = keys(mc)
   table.sort(kl)
   for _, c in ipairs(kl) do
      for n = 1, mc[c] do
         table.insert(out, c)
      end
   end
   return out
end

function keys(t)
   local a = {}
   for k, v in pairs(t) do
      table.insert(a, k)
   end
   return a
end

function counterify(a)
   local cc = {}
   for _, c in ipairs(a) do
      if cc[c] == nil then
         cc[c] = 0
      end
      cc[c] = cc[c] + 1
   end
   return cc
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

if recursive_compare(commoncharacters({"bella", "label", "roller"}), {"e", "l", "l"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(commoncharacters({"cool", "lock", "cook"}), {"c", "o"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(commoncharacters({"hello", "world", "pole"}), {"l", "o"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(commoncharacters({"abc", "def", "ghi"}), {}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(commoncharacters({"aab", "aac", "aaa"}), {"a", "a"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

