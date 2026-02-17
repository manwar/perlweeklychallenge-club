--# https://theweeklychallenge.org/blog/perl-weekly-challenge-361/
--[[

Task 1: Zeckendorf Representation

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a positive integer (<= 100).

   Write a script to return Zeckendorf Representation of the given
   integer.

     Every positive integer can be uniquely represented as sum of
     non-consecutive Fibonacci numbers.

Example 1

Input: $int = 4
Output: 3,1

4 => 3 + 1 (non-consecutive fibonacci numbers)

Example 2

Input: $int = 12
Output: 8,3,1

12 => 8 + 3 + 1

Example 3

Input: $int = 20
Output: 13,5,2

20 => 13 + 5 + 2

Example 4

Input: $int = 96
Output: 89,5,2

96 => 89 + 5 + 2

Example 5

Input: $int = 100
Output: 89,8,3

100 => 89 + 8 + 3

Task 2: Find Celebrity
--]]
--# solution by pokgopun@gmail.com

--@param int
local function zkd(n) --@return ints table
	if n <= 3 then
		return {n}
	end
	local fib = {0, 1, 1, 2, 3}
	local i = 5
	while fib[i] < n do
		table.insert(fib, fib[i] + fib[i-1])
		i = i + 1
	end
	local ints = {}
	while n > 0 do
		local v = fib[i]
		if v <= n then
			n = n - v
			table.insert(ints, v)
		end
		i = i - 1
	end
	return ints
end

local lu = require("luaunit")

function TestZkd()
	local data = {
		4 ,{3,1 },
		12 ,{8,3,1 },
		20 ,{13,5,2 },
		96 ,{89,5,2 },
		100 ,{89,8,3},
	}
	for i=2, #data, 2 do
		local inpt, otpt = data[i-1], data[i]
		lu.assertEquals(zkd(inpt), otpt)
	end
end

lu.run()
