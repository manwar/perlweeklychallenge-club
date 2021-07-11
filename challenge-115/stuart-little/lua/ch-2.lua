#!/usr/bin/env lua

-- run <script> <space-separated digits>

table.sort(arg)
s = table.concat(arg,"")
fst,odds,rest = s:match("(.)([13579]*)(.*)")

if fst and ("02468"):find(fst) then
   print(s:reverse())
   os.exit()
end

if rest and rest:sub(1,1) ~= "" and ("02468"):find(rest:sub(1,1)) then
   print(rest:sub(2):reverse() .. odds:reverse() .. fst .. rest:sub(1,1))
   os.exit()
end

print("No even digits.")
