#!/usr/bin/env lua

-- run <script> <time>

function angl(h,m)
   rawDiff = math.abs((h % 12)*30 + m/2 - m * 6)
   return math.min(rawDiff, 360-rawDiff)
end

for h,m in string.gmatch(arg[1], "(%w+):(%w+)") do
   print(angl(h,m))
end

