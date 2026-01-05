--# https://theweeklychallenge.org/blog/perl-weekly-challenge-355/
--[[

Task 1: Thousand Separator

Submitted by: [48]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a positive integer, $int.

   Write a script to add thousand separator, , and return as string.

Example 1

Input: $int = 123
Output: "123"

Example 2

Input: $int = 1234
Output: "1,234"

Example 3

Input: $int = 1000000
Output: "1,000,000"

Example 4

Input: $int = 1
Output: "1"

Example 5

Input: $int = 12345
Output: "12,345"

Task 2: Mountain Array
--]]
--# solution by pokgopun@gmail.com

--@param int integer
local function ts(int) --@return string
	local dgtStr, last
	dgtStr = tostring(int)
	last = #dgtStr
	while true do
		last = last - 3
		if last < 1 then
			break
		end
		dgtStr = (dgtStr):sub(1,last) .. "," .. (dgtStr):sub(last+1)
	end
	return dgtStr
end

local lu = require("luaunit")

function TestTs()
	local data = {
		123, "123",
		1234, "1,234",
		1000000, "1,000,000",
		1, "1",
		12345, "12,345"
	}
	local inpt, otpt
	for i=2, #data, 2 do
		inpt, otpt = data[i-1], data[i]
		lu.assertEquals(ts(inpt), otpt)
	end
end

lu.run()
