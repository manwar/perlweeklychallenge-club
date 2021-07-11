#!/usr/bin/env lua

-- run <script> <number>

sm=0
for i = 1,arg[1]:len() do
   sm = sm + arg[1]:sub(i,i)^2
end
print(math.sqrt(sm) == math.floor(math.sqrt(sm)) and 1 or 0)
