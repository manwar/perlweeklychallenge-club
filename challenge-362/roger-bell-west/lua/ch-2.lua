#! /usr/bin/lua

function map(seq, func)
   local out = {}
   for _, x in ipairs(seq) do
      table.insert(out, func(x))
   end
   return out
end

function joins(t, pad)
   local out = ""
   local later = false
   for k,v in pairs(t) do
      if later then
         out = out .. pad
      end
      out = out .. v
      later = true
   end
   return out
end

function spellboundsorting(a)
   local o = a
   local ow = map(o, towords)
   local i = {}
   for j = 1, #o do
      table.insert(i, j)
   end
   table.sort(i,
              function(aa, bb) return ow[aa] < ow[bb] end)
   o = map(i, function(x) return o[x] end)
   return o
end

function towords(a)
   if a == 0 then
      return "zero"
   end
   local components = {}
   local b = a
   if a < 0 then
      b = -a
      table.insert(components, "minus")
   end
   local vw = {
      {1000000000, "milliard"},
      {1000000, "million"},
      {1000, "thousand"},
      {100, "hundred"},
      {90, "ninety"},
      {80, "eighty"},
      {70, "seventy"},
      {60, "sixty"},
      {50, "fifty"},
      {40, "forty"},
      {30, "thirty"},
      {20, "twenty"},
      {19, "nineteen"},
      {18, "eighteen"},
      {17, "seventeen"},
      {16, "sixteen"},
      {15, "fifteen"},
      {14, "fourteen"},
      {13, "thirteen"},
      {12, "twelve"},
      {11, "eleven"},
      {10, "ten"},
      {9, "nine"},
      {8, "eight"},
      {7, "seven"},
      {6, "six"},
      {5, "five"},
      {4, "four"},
      {3, "three"},
      {2, "two"},
      {1, "one"},
   }
   for _, w in ipairs(cw(b, vw)) do
      table.insert(components, w)
   end
   return joins(components, " ")
end

function cw(n, vw)
   local res = {}
   for _, vx in ipairs(vw) do
      local val = vx[1]
      local word = vx[2]
      if n >= val then
         local andflat = false
         if n >= 100 then
            andflag = true
            for _, w in ipairs(cw(n // val, vw)) do
               table.insert(res, w)
            end
         end
         table.insert(res, word)
         local p = n % val
         if p > 0 then
            if andflag then
               table.insert(res, "and")
            end
            for _, w in ipairs(cw(p, vw)) do
               table.insert(res, w)
            end
         end
         break
      end
   end
   return res
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

if recursive_compare(spellboundsorting({6, 7, 8, 9, 10}), {8, 9, 7, 6, 10}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(spellboundsorting({-3, 0, 1000, 99}), {-3, 99, 1000, 0}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(spellboundsorting({1, 2, 3, 4, 5}), {5, 4, 1, 3, 2}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(spellboundsorting({0, -1, -2, -3, -4}), {-4, -1, -3, -2, 0}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(spellboundsorting({100, 101, 102}), {100, 101, 102}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

