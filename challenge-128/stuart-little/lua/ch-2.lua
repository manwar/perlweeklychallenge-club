#!/usr/bin/env lua

-- run <script> <starting arrivals followed by departures, all space-separated>

local times={}
for k,v in ipairs(arg) do
   table.insert(times,{v,1 + ((k-1) % math.floor(#arg/2))})
end
table.sort(times, function(a,b) if a[1] < b[1] then return true else return false end end)

local sol=0
local station={}
for i=1,math.floor(#arg/2) do
   table.insert(station,0)
end

for _,v in ipairs(times) do
   station[v[2]] = station[v[2]] ~ 1
   local sm=0
   for _,val in ipairs(station) do
      sm = sm + val
   end
   if sm > sol then sol = sm end
end

print(sol)

