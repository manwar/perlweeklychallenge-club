#!/usr/bin/env lua

-- run <script> <path-to-file>

sm,nrln=0,0
for ln in io.lines(arg[1]) do
   nr = ln:match("[^%d]*(%d+)")
   sm = sm + nr
   nrln = nrln+1
end
print(("%d"):format((nrln+1)*(nrln+2)/2 - sm))
