#! /usr/bin/lua

-- by hookenz at
-- https://stackoverflow.com/questions/9168058/how-to-dump-a-table-to-console
function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

local t = {}

for line in io.lines("temperature.txt") do
   local a,b,c,d = string.find(line, "([-%d]+), *(%d+)")
   if a ~= nil then
      t[c] = 0 + d
   end
end

local dk = {}
for k,v in pairs(t) do
   table.insert(dk,k)
end
table.sort(dk)

local lt = 999
for dummy,k in ipairs(dk) do
   if t[k] > lt then
      print(k)
   end
   lt = t[k]
end

