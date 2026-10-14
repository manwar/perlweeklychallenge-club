#! /usr/bin/lua

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

function deepcopy(src)
   local dst = {}
   for k, v in pairs(src) do
      if type(v) == "table" then
         v = deepcopy(v)
      end
      dst[k] = v
   end
   return dst
end

function wordsquares(a)
   local l = #{a[1]}
   local queue = {}
   for _, w in ipairs(a) do
      table.insert(queue, {w})
   end
   while #queue > 0 do
      local p = table.remove(queue, 1)
      if #p == l then
         return p
      end
      local ps = {}
      for w in p do
         ps[w] = true
      end
      for ca in words do
         if ps[ca] == nil then
            local valid = true
            local ca = split(ca)
            for i, c in ipairs(cas) do
               if i > #p then
                  break
               end
               if c ~= string.sub(p[i], #p + 1, #p + 1) then
                  valid = false
                  break
               end
            end
            if valid then
               local pw = deepcopy(p)
               table.insert(pw, ca)
               table.insert(queue, pw)
            end
         end
      end
   end
   return {}
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

if recursive_compare(wordsquares({"MA", "AM", "MY", "ME"}), {"MA", "AM"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(wordsquares({"SUN", "USE", "NET", "SEE", "TEN"}), {"SUN", "USE", "NET"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(wordsquares({"BOAT", "TEAL", "AREA", "TSAR", "OGRE"}), {"BOAT", "OGRE", "AREA", "TEAL"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(wordsquares({"CARD", "AREA", "REAR", "DART"}), {"CARD", "AREA", "REAR", "DART"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(wordsquares({"HEART", "TREND", "EMBER", "RESIN", "ABUSE"}), {"HEART", "EMBER", "ABUSE", "RESIN", "TREND"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

