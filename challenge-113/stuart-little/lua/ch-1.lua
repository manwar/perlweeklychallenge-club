#!/usr/bin/env lua

-- run <script> <number> <digit>

if (arg[1]:find(arg[2]) or tonumber(arg[1]) >= 100 or tonumber(arg[2]) ~= 0 and tonumber(arg[1]) >= 11 * arg[2]) then
   print(1)
   os.exit()
end
for i = 0,10 do
   dff = arg[1]-i*arg[2]
   if (dff % 10 == 0 and dff >= 0) then
      print(1)
      os.exit()
   end
end
print(0)
