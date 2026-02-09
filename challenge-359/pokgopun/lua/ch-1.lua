--# https://theweeklychallenge.org/blog/perl-weekly-challenge-359/
--[[

Task 1: Digital Root

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a positive integer, $int.

   Write a function that calculates the additive persistence of a positive
   integer and also return the digital root.

     Digital root is the recursive sum of all digits in a number until a
     single digit is obtained.

     Additive persistence is the number of times you need to sum the
     digits to reach a single digit.

Example 1

Input: $int = 38
Output: Persistence  = 2
        Digital Root = 2

38 => 3 + 8 => 11
11 => 1 + 1 => 2

Example 2

Input: $int = 7
Output: Persistence  = 0
        Digital Root = 7

Example 3

Input: $int = 999
Output: Persistence  = 2
        Digital Root = 9

999 => 9 + 9 + 9 => 27
27  => 2 + 7 => 9

Example 4

Input: $int = 1999999999
Output: Persistence  = 3
        Digital Root = 1

1999999999 => 1 + 9 + 9 + 9 + 9 + 9 + 9 + 9 + 9 + 9 => 82
82 => 8 + 2 => 10
10 => 1 + 0 => 1

Example 5

Input: $int = 101010
Output: Persistence  = 1
        Digital Root = 3

101010 => 1 + 0 + 1 + 0 + 1 + 0 => 3

Task 2: String Reduction
--]]
--# solution by pokgopun@gmail.com
--@param int
local function digitalRoot(n) --@return int, int
	local c = 0
	while n > 9 do
		c = c + 1
		local d = tostring(n)
		n = 0
		for v in d:gmatch(".") do
			n = n + v
		end
	end
	return c, n
end

local lu = require("luaunit")

function TestDigitalRoot()
	local data = {
		38, 2, 2,
		7, 0, 7,
		999, 2, 9,
		1999999999, 3, 1,
		101010, 1, 3,
	}
	local inpt, otpt
	for i=3, #data, 3 do
		inpt, otpt = data[i-2], {data[i-1], data[i], n=2}
		lu.assertEquals(table.pack(digitalRoot(inpt)), otpt) 
	end
end

lu.run()
