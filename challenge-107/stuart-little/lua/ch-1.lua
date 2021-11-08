#!/usr/bin/env lua

-- run <script>

local t={
   [100]={4,1210},
   [136]={4,2020},
   [1425]={5,21200},
}

for _,v in ipairs({100,136,1425}) do
   print(("Base 10: %d"):format(v))
   print(("Base %d: %d\n"):format(t[v][1],t[v][2]))
end
