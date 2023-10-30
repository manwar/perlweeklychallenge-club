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

function commoncharacters(a)
   local ac = {}
   for _i, w in ipairs(a) do
      local h = {}
      for _j, c in ipairs(split(w)) do
         if h[c] == nil then
            h[c] = 1
         else
            h[c] = h[c] + 1
         end
      end
      table.insert(ac, h)
   end
   local vc = deepcopy(ac[1])
   for i, aa in ipairs(ac) do
      if i > 1 then
         for c, ct in pairs(vc) do
            if aa[c] == nil then
               vc[c] = nil
            elseif aa[c] < vc[c] then
               vc[c] = aa[c]
            end
         end
      end
   end
   local out = {}
   for _, c in ipairs(split(a[1])) do
      if vc[c] ~= nil then
         table.insert(out, c)
         vc[c] = vc[c] - 1
         if vc[c] == 0 then
            vc[c] = nil
         end
      end
   end
   return out
end

if recursive_compare(commoncharacters({"java", "javascript", "julia"}), {"j", "a"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

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
print("")

