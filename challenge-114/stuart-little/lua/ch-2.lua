#!/usr/bin/env lua

-- run <script> <number>

inpt = arg[1]
t={[0]=0,[1]=0}

while (inpt & 3 ~= 1) do
   t[inpt%2] = t[inpt%2] + 1
   inpt = inpt >> 1
end

print(("%d"):format((inpt+1)*2^(t[0]+t[1]) + 2^(t[1])-1))
