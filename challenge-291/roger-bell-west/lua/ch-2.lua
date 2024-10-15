#! /usr/bin/lua

-- by Michael Anderson at
-- https://stackoverflow.com/questions/8722620/comparing-two-index-tables-by-index-value-in-lua
function recursive_compare(t1,t2)
   if t1==t2 then return true end
   if (type(t1)~="table") then return false end
   local mt1 = getmetatable(t1)
   local mt2 = getmetatable(t2)
   if( not recursive_compare(mt1,mt2) ) then return false end
   for k1,v1 in pairs(t1) do
      local v2 = t2[k1]
      if( not recursive_compare(v1,v2) ) then return false end
   end
   for k2,v2 in pairs(t2) do
      local v1 = t1[k2]
      if( not recursive_compare(v1,v2) ) then return false end
   end
   return true  
end

function propersize(t)
   local l=0
   for k,v in pairs(t) do
      l = l + 1
   end
   return l
end

function combinations(arr, k)
   local c = {}
   for i = 1, k do
      table.insert(c, i)
   end
   table.insert(c, #arr + 1)
   table.insert(c, 0)
   local out = {}
   while true do
      local inner = {}
      for i = k, 1, -1 do
         table.insert(inner, arr[c[i]])
      end
      table.insert(out, inner)
      local j = 1
      while c[j] + 1 == c[j + 1] do
         c[j] = j
         j = j + 1
      end
      if j > k then
         break
      end
      c[j] = c[j] + 1
   end
   return ipairs(out)
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

local deck = {}
for suit = 0, 3 do
   for rank = 1, 13 do
      table.insert(deck, {rank, suit})
   end
end

local hands = {}

for _, hand in combinations(deck, 5) do
   local ranks = {}
   local suits = {}
   for i, c in ipairs(hand) do
      table.insert(ranks, c[1])
      table.insert(suits, c[2])
   end
   table.sort(ranks)
   local ranksc = counterify(ranks)
   local ranksk = {}
   for k, v in pairs(ranksc) do
      table.insert(ranksk, v)
   end
   table.sort(ranksk, function (i, j) return j < i end)
   table.sort(suits)
   local suitsc = counterify(suits)
   local suitsk = {}
   for k, v in pairs(suitsc) do
      table.insert(suitsk, v)
   end
   table.sort(suitsk, function (i, j) return j < i end)
   local bin = 0
   -- Can't generate 5 of a kind.
   -- Royal flush
   if  propersize(suitsc) == 1 and
      recursive_compare(ranks, {1, 10, 11, 12, 13}) then
      bin = 2
   end
   -- Straight flush
   if bin == 0 and
      propersize(suitsc) == 1 and
      math.min(table.unpack(ranks)) + 4 == math.max(table.unpack(ranks)) then
      bin = 2
   end
   -- Four of a kind
   if bin == 0 and ranksk[1] == 4 then
      bin = 3
   end
   -- Full house
   if bin == 0 and ranksk[1]== 3 and ranksk[2]== 2 then
      bin = 4
   end
   -- Flush
   if bin == 0 and suitsk[1]== 5 then
      bin = 5
   end
   -- Straight
   if bin == 0 and
      -- match full rank struct
      (
         (ranks[1] + 1 == ranks[2] and
          ranks[2] + 1 == ranks[3] and
          ranks[3] + 1 == ranks[4] and
          ranks[4] + 1 == ranks[5])
         or
         recursive_compare(ranks, {1, 10, 11, 12, 13})
   ) then
      bin = 6
   end
   -- Three of a kind
   if bin == 0 and ranksk[1]== 3 then
      bin = 7
   end
   -- Two pair
   if bin == 0 and ranksk[1]== 2 and ranksk[2] == 2 then
      bin = 8
   end
   -- One pair
   if bin == 0 and ranksk[1] == 2 then
      bin = 9
   end
   -- Anything else is High card
   if bin == 0 then
      bin = 10
   end
   if hands[bin] == nil then
      hands[bin] = 0
   end
   hands[bin] = hands[bin] + 1
end
local tk = keys(hands)
table.sort(tk)
local tot = 0
for i, k in ipairs(tk) do
   print(k .. " " .. hands[k])
   tot = tot + hands[k]
end
print("total " .. tot)
