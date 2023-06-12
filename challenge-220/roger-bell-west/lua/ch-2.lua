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
  for k, _ in pairs(kk) do
     if (not recursive_compare(t1[k], t2[k])) then
        return false
     end
  end
  return true
end

function keys(t)
   local a = {}
   for k, v in pairs(t) do
      table.insert(a, k)
   end
   return a
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

function permute(a)
   local out = {}
   local n = #a
   local c = {}
   for i = 1,n do
      table.insert(c, 1)
   end
   table.insert(out, deepcopy(a))
   local i=1
   while true do
      if i > n then
         break
      end
      if c[i] < i then
         if i % 2 == 1 then
            a[1],a[i] = a[i],a[1]
         else
            a[c[i]],a[i] = a[i],a[c[i]]
         end
         table.insert(out, deepcopy(a))
         c[i] = c[i]+1
         i = 1
      else
         c[i] = 1
         i = i+1
      end
   end
   return out
end

function propersize(t)
   local l=0
   for k,v in pairs(t) do
      l = l + 1
   end
   return l
end

function squared(a)
   return a * a
end

function encode(sq, base)
   local a = 0
   for _, v in ipairs(sq) do
      a = a * base
      a = a + v
   end
   return a
end

function decode(a, base)
   local eq = {}
   while a > 0 do
      table.insert(eq, 1, a % base)
      a = a // base
   end
   return eq
end

function squareful(lst)
   local results = {}
   local squares = {}
   local base = math.max(table.unpack(lst)) + 1
   for _, la in ipairs(permute(lst)) do
      local squareful = true
      for i = 1, #la-1 do
         local cs = la[i] + la[i + 1]
         local mx = squared(propersize(squares))
         while cs > mx do
            mx = squared(propersize(squares) + 1)
            squares[mx] = true
         end
         if squares[cs] == nil then
            squareful = false
            break
         end
      end
      if squareful then
         results[encode(la, base)] = true
      end
   end
   local o = keys(results)
   table.sort(o)
   local out = {}
   for _, v in ipairs(o) do
      table.insert(out, decode(v, base))
   end
   return out
end

if recursive_compare(squareful({1, 17, 8}), {{1, 8, 17}, {17, 8, 1}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(squareful({2, 2, 2}), {{2, 2, 2}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

