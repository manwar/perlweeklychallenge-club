#!/usr/bin/env lua

-- run <script> <number>

function no1(nr)
   if (nr:len() == 0) then return 0 end
   if (nr:sub(1,1) == '1') then return 9^(nr:len()-1) end
   return (tonumber(nr:sub(0,1))-1) * 9^(nr:len()-1) + no1(nr:sub(2))
end

print((not arg[1]:find('1')) and math.floor(no1(arg[1])) or math.floor(no1(arg[1])-1))
