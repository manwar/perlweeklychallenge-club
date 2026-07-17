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

function isqrt(s)
   if s <= 1 then
      return s
   end
   local x0 = s // 2
   local x1 = (x0 + s // x0) // 2
   while x1 < x0 do
      x0 = x1
      x1 = (x0 + s // x0) // 2
   end
   return x0
end

function listtoset(a)
   local s = {}
   for _, x in ipairs(a) do
      s[x] = true
   end
   return s
end

function is_adjacentsquared(param, hc)
   local hcs = deepcopy(hc)
   table.sort(hcs, function (i,j) return i < j end)
   local ref = {}
   for qi = 1, param do
      table.insert(ref, qi)
   end
   if not recursive_compare(ref, hcs) then
      return false
   end
   for i = 1, param - 1 do
      local pn = hc[i] + hc[i + 1]
      local sn = isqrt(pn)
      if sn * sn ~= pn then
         return false
      end
   end
   local pn = hc[1] + hc[#hc]
   local sn = isqrt(pn)
   if sn * sn ~= pn then
      return false
   end
   return true
end

function hamiltoniancycle(a)
   if a < 31 then
      return {}
   end
   local perfectsquares = {}
   local lim = a * 2
   for p = 1, a do
      local ps = p * p
      if ps > lim then
         break
      end
      perfectsquares[ps] = true
   end
   local neighbours = {}
   for x = 1, a do
      for y, _ in pairs(perfectsquares) do
         if y > x then
            local z = y - x
            if z <= a then
               local s = {}
               if neighbours[x] ~= nil then
                  s = neighbours[x]
               end
               s[z] = true
               neighbours[x] = s
               s = {}
               if neighbours[z] ~= nil then
                  s = neighbours[z]
               end
               s[x] = true
               neighbours[z] = s
            end
         end
      end
   end
   local stack = {}
   table.insert(stack, {1})
   while #stack > 0 do
      local lst = table.remove(stack, #stack)
      if #lst == a then
         if perfectsquares[lst[1] + lst[#lst]] ~= nil then
            return lst
         end
      else
         local already = listtoset(lst)
         for candidate, _ in pairs(neighbours[lst[#lst]]) do
            if already[candidate] == nil then
               local nlst = deepcopy(lst)
               table.insert(nlst, candidate)
               table.insert(stack, nlst)
            end
         end
      end
   end
   return {}
end

if is_adjacentsquared(32, hamiltoniancycle(32)) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(hamiltoniancycle(15), {}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if is_adjacentsquared(34, hamiltoniancycle(34)) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

