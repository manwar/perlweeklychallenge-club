--# https://theweeklychallenge.org/blog/perl-weekly-challenge-365/
--[[

Task 1: Alphabet Index Digit Sum

Submitted by: [64]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string $str consisting of lowercase English letters,
   and an integer $k.

   Write a script to convert a lowercase string into numbers using
   alphabet positions (a=1 … z=26), concatenate them to form an integer,
   then compute the sum of its digits repeatedly $k times, returning the
   final value.

Example 1

Input: $str = "abc", $k = 1
Output: 6

Conversion: a = 1, b = 2, c = 3 -> 123
Digit sum: 1 + 2 + 3 = 6

Example 2

Input: $str = "az", $k = 2
Output: 9

Conversion: a = 1, z = 26 -> 126
1st sum: 1 + 2 + 6 = 9
2nd sum: 9

Example 3

Input: $str = "cat", $k = 1
Output: 6

Conversion: c = 3, a = 1, t = 20 -> 3120
Digit sum: 3 + 1 + 2 + 0 = 6

Example 4

Input: $str = "dog", $k = 2
Output: 8

Conversion: d = 4, o = 15, g = 7 -> 4157
1st sum: 4 + 1 + 5 + 7 = 17
2nd sum: 1 + 7 = 8

Example 5

Input: $str = "perl", $k = 3
Output: 6

Conversion: p = 16, e = 5, r = 18, l = 12 -> 1651812
1st sum: 1 + 6 + 5 + 1 + 8 + 1 + 2 = 24
2nd sum: 2+4 = 6
3rd sum: 6

Task 2: Valid Token Counter
]]
--# solution by pokgopun@gmail.com

--@param string, int
local function convert(str, o) --@return int
	local n = 0
	str:gsub(".", function(m)
		n = n + m:byte() - o
	end)
	return n
end

--@param string, int
local function aids(str, k) --@return int
	local n = convert(str, 96)
	while n > 9 and k > 0 do
		k = k - 1
		n = convert(tostring(n), 48)
	end
	return n
end

local lu = require("luaunit")

function TestAids()
	local data = {
		"abc", 1 , 6 ,
		"az", 2 , 9 ,
		"cat", 1 , 6 ,
		"dog", 2 , 8 ,
		"perl", 3 , 6
	}
	for i=3, #data, 3 do
		local  str, k, otpt = data[i-2], data[i-1], data[i]
		lu.assertEquals(aids(str, k), otpt)
	end
end

lu.run()
