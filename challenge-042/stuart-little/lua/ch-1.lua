#!/usr/bin/env lua

-- run <script> <largest decimal number to convert; defaults to 50>

for n=0,(#arg>0 and tonumber(arg[1]) or 50) do
   print(("Decimal: %d    Octal: %o"):format(n,n))
end
