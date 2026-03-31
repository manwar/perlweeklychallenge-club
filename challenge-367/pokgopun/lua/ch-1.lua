--# https://theweeklychallenge.org/blog/perl-weekly-challenge-367/
--[[

Task 1: Max Odd Binary

Submitted by: [61]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a binary string that has at least one ‘1’.

   Write a script to rearrange the bits in such a way that the resulting
   binary number is the maximum odd binary number and return the resulting
   binary string. The resulting string can have leading zeros.

Example 1

Input: $str = "1011"
Output: "1101"

"1101" is max odd binary (13).

Example 2

Input: $str = "100"
Output: "001"

"001" is max odd binary (1).

Example 3

Input: $str = "111000"
Output: "110001"

Example 4

Input: $str = "0101"
Output: "1001"

Example 5

Input: $str = "1111"
Output: "1111"

Task 2: Conflict Events
]]
--# solution by pokgopun@gmail.com

--@param string
local function mob(str) --@return string
	--return (function(res, c) return ("1"):rep(c-1)..res.."1" end)(str:gsub("1", ""))
	local res, c = str:gsub("1", "")
	return ("1"):rep(c-1)..res.."1" 
end

local lu = require("luaunit")

function TestMob()
	local data = {
		"1011" , "1101" ,
		"100" , "001" ,
		"111000" , "110001" ,
		"0101" , "1001" ,
		"1111" , "1111",
	}
	for i=2, #data, 2 do
		local inpt, otpt = data[i-1], data[i]
		lu.assertEquals(mob(inpt), otpt)
	end
end

lu.run()
