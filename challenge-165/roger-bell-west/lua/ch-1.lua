#! /usr/bin/lua

local points = {}
local lines = {}
local x = {}
local y = {}

while true do
   local line = io.read()
   if line == nil then break end
   local f = {}
   for v in string.gmatch(line,'%d+') do
      table.insert(f,v)
   end
   for i = 1, #f do
      if i % 2 == 1 then
         table.insert(x,f[i])
      else
         table.insert(y,f[i])
      end
   end
   if #f == 4 then
      table.insert(lines,f)
   elseif #f == 2 then
      table.insert(points,f)
   end
end

local mnx = math.min(table.unpack(x))
local mxx = math.max(table.unpack(x))

local mny = math.min(table.unpack(y))
local mxy = math.max(table.unpack(y))

local lo = {
   mnx - (mxx-mnx)/10,
   mny - (mxy-mny)/10,
}

local hi = {
   mxx + (mxx-mnx)/10,
   mxy + (mxy-mny)/10,
}

local w = hi[1] - lo[1]
local h = hi[2] - lo[2]

print('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>')
print('<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">')
print(string.format(
         '<svg width="%f" height="%f" viewBox="%f %f %f %f" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">',
         w,h,lo[1],lo[2],w,h
))

if #lines > 0 then
   print('  <g id="lines" stroke="#369" stroke-width="4">')
   for k,p in pairs(lines) do
      print(string.format('    <line x1="%f" y1="%f" x2="%f" y2="%f" />',table.unpack(p)))
   end
   print('  </g>')
end

if #points > 0 then
   print('  <g fill="#f73" id="points">')
   for k,p in pairs(points) do
      print(string.format('    <circle cx="%f" cy="%f" r="3"',table.unpack(p)))
   end
   print('  </g>')
end

print('</svg>')
