#!/usr/bin/env lua

-- run <script> <space-separated set entries, with a '-' separating the two sets>

local s1={}
while arg[1] ~= '-' do
   table.insert(s1,table.remove(arg,1))
end
table.remove(arg,1)
for _,i in ipairs(s1) do
   for _,j in ipairs(arg) do
      if i == j then
	 print(0)
	 os.exit()
      end
   end
end
print(1)
