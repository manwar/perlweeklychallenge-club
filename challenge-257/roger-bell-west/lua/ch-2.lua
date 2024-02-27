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

function reducedrowechelon(a)
   local leadingone = {}
   for _, row in ipairs(a) do
      local lp = -1
      for cn, cell in ipairs(row) do
         if cell == 1 then
            lp = cn - 1
            break
         elseif cell ~= 0 then
            return false
         end
      end
      table.insert(leadingone, lp)
   end
   while leadingone[#leadingone] == -1 do
      table.remove(leadingone)
   end
   local c = leadingone
   table.sort(c, function (i, j) return i < j end)
   if c[1] == -1 then
      return false
   end
   if not recursive_compare(c, leadingone) then
      return false
   end
   for _, i in ipairs(c) do
      local col = {}
      for _b, row in ipairs(a) do
         table.insert(col, row[i + 1])
      end
      table.sort(col, function (i, j) return i < j end)
      if col[#col] ~= 1 or col[#col - 1] ~= 0 or col[1] ~= 0 then
         return false
      end
   end
   return true
end

if not reducedrowechelon({{1, 1, 0}, {0, 1, 0}, {0, 0, 0}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if reducedrowechelon({{0, 1, -2, 0, 1}, {0, 0, 0, 1, 3}, {0, 0, 0, 0, 0}, {0, 0, 0, 0, 0}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if reducedrowechelon({{1, 0, 0, 4}, {0, 1, 0, 7}, {0, 0, 1, -1}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not reducedrowechelon({{0, 1, -2, 0, 1}, {0, 0, 0, 0, 0}, {0, 0, 0, 1, 3}, {0, 0, 0, 0, 0}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not reducedrowechelon({{0, 1, 0}, {0, 1, 0}, {0, 0, 0}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not reducedrowechelon({{4, 0, 0, 0}, {0, 1, 0, 7}, {0, 0, 1, -1}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not reducedrowechelon({{1, 0, 0, 4}, {1, 0, 0, 7}, {0, 0, 1, -1}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not reducedrowechelon({{1, -2, 0, 4}, {0, 1, 0, 7}, {0, 0, 1, -1}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

