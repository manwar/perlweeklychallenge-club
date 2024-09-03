#! /usr/bin/lua

-- from https://rosettacode.org/wiki/Cartesian_product_of_two_or_more_lists#Lua
-- support:
function T(t) return setmetatable(t, {__index=table}) end
table.clone = function(t) local s=T{} for k,v in ipairs(t) do s[k]=v end return s end
table.reduce = function(t,f,acc) for i=1,#t do acc=f(t[i],acc) end return acc end

-- implementation:
local function cartesian(sets)
  local temp, prod = T{}, T{}
  local function descend(depth)
    for _,v in ipairs(sets[depth]) do
      temp[depth] = v
      if (depth==#sets) then prod[#prod+1]=temp:clone() else descend(depth+1) end
    end
  end
  descend(1)
  return prod
end

function makingchange(a)
   local coins = {1, 5, 10, 25, 50}
   local pat = {}
   for _, x in ipairs(coins) do
      local max = math.floor(a / x)
      if max > 0 then
         local t = {}
         for i = 0, max do
            table.insert(t, i)
         end
         table.insert(pat, t)
      else
         break
      end
   end
   local ct = 0
   for _, combo in ipairs(cartesian(pat)) do
      local t = 0
      for i, c in ipairs(combo) do
         t = t + c * coins[i]
         if t > a then
            break
         end
      end
      if t == a then
         ct = ct + 1
      end
   end
   return ct
end

if makingchange(9) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if makingchange(15) == 6 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if makingchange(100) == 292 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

