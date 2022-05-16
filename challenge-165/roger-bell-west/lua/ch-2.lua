#! /usr/bin/lua

function median(s0)
   local s = s0
   table.sort(s)
   return s[math.floor(#s/2)+1]
end

local points = {}

while true do
   local line = io.read()
   if line == nil then break end
   local f = {}
   for x,y in string.gmatch(line,'(%d+),(%d+)') do
      print(string.format('%d,%d',x,y))
      table.insert(points,{x,y})
   end
end

local slope = {}
for i = 1,#points-1 do
   for j = i+1,#points do
      if points[i][1] ~= points[j][1] then
         table.insert(slope,
                      (points[j][2]-points[i][2])/(points[j][1]-points[i][1])
         )
      end
   end
end

local m = median(slope)
local offset = {}
local x = {}
for i,p in pairs(points) do
   table.insert(offset,p[2] - m * p[1])
   table.insert(x,p[1]+0)
end
local c = median(offset)

local l = {}

table.sort(x)

for i,xb in pairs({x[1],x[#x]}) do
   table.insert(l,xb)
   table.insert(l,xb * m + c)
end

print(string.format('%f,%f,%f,%f',table.unpack(l)))


