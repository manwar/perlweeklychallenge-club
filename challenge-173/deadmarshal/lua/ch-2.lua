-- https://github.com/edubart/lua-bint
-- To install this library: luarocks install bint
local bint = require 'bint'(1024)

local function product(t, last)
   assert(type(t) == 'table' and
	  type(last) == 'number',
	  't, last must be table, number, number respectively!')
   local prod = bint(1)
   for i=1, last do prod = prod * t[i] end
   return prod
end

local function sylvesters_sequence()
   local t = {2,3}
   while(#t ~= 10) do
      t[#t+1] = bint(product(t, #t) + 1)
   end
   return t
end

local t = sylvesters_sequence()
for i=1, #t do print(t[i]) end

