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

function shuffle(input)
   local ix = {}
   local keys = {}
   for n = 1, #input do
      table.insert(ix, n)
      table.insert(keys, math.random())
   end
   table.sort(ix, function (i, j) return keys[i] < keys[j] end)
  local out = {}
  for _, v in ipairs(ix) do
      table.insert(out, input[v])
   end
   return out
end

function sixoffortynine()
   local candidates = {}
   for n = 1, 49 do
      table.insert(candidates, n)
   end
   candidates = shuffle(candidates)
   local o = {}
   for n = 1, 6 do
      table.insert(o, candidates[n])
   end
   candidates = o
   table.sort(candidates, function (i, j) return i < j end)
   for n = 1, 6 do
      print(candidates[n])
   end
end

sixoffortynine()
