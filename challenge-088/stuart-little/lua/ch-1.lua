#!/usr/bin/env lua

-- run <script> <space-separated numbers>

local prod,prods=1,{}
for _,v in ipairs(arg) do prod=prod*v end
for _,v in ipairs(arg) do table.insert(prods,("%d"):format(prod/v)) end
print(table.unpack(prods))
