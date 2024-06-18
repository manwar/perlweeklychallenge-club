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

function busroute(a)
   local routes = {}
   for _, rt in ipairs(a) do
      local ri = {}
      local interval = rt[1]
      local offset = rt[2]
      local duration = rt[3]
      local start = offset
      while start <= 60 + offset do
         ri[start] = start + duration
         start = start + interval
      end
      table.insert(routes, rt)
   end
   local out = {}
   for t = 0, 59 do
      local best = {}
      local at = -1
      local nxt = {}
      local ndt = -1
      for i, r in ipairs(routes) do
         local nb = 999
         local nt = 0
         for n, l in ipairs(r) do
            if n >= t then
               if l < nb then
                  nb = n
                  nt = l
               end
            end
         end
         if at == -1 or nt < at then
            best = {}
            at = nt
         end
         if nt <= at then
            best[i] = true
         end
         if ndt == -1 or nb < ndt then
            nxt = {}
            ndt = nb
         end
         if nb <= ndt then
            nxt[i] = true
         end
      end
      local intersect = {}
      for k, v in pairs(best) do
         if nxt[k] ~= nil then
            table.insert(intersect, k)
         end
      end
      if #intersect == 0 then
         table.insert(out, t)
      end
   end
   return out
end

if recursive_compare(busroute({{12, 11, 41}, {15, 5, 35}}), {36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(busroute({{12, 3, 41}, {15, 9, 35}, {30, 5, 25}}), {0, 1, 2, 3, 25, 26, 27, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 55, 56, 57, 58, 59}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

