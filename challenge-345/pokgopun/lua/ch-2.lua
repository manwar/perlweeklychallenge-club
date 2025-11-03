--# https://theweeklychallenge.org/blog/perl-weekly-challenge-345/
--[[

Task 2: Last Visitor

Submitted by: [44]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an integer array @ints where each element is either a
   positive integer or -1.

   We process the array from left to right while maintaining two lists:
@seen: stores previously seen positive integers (newest at the front)
@ans: stores the answers for each -1

   Rules:
If $ints[i] is a positive number -> insert it at the front of @seen
If $ints[i] is -1:

   Let $x be how many -1s in a row we’ve seen before this one.

   If $x < len(@seen) -> append seen[x] to @ans

   Else -> append -1 to @ans

   At the end, return @ans.

Example 1

Input: @ints = (5, -1, -1)
Output: (5, -1)

@seen = (5)
First  -1: @ans = (5)
Second -1: @ans = (5, -1)

Example 2

Input: @ints = (3, 7, -1, -1, -1)
Output: (7, 3, -1)

@seen = (3, 7)
First  -1: @ans = (7)
Second -1: @ans = (7, 3)
Third  -1: @ans = (7, 3, -1)

Example 3

Input: @ints = (2, -1, 4, -1, -1)
Output: (2, 4, 2)

Example 4

Input: @ints = (10, 20, -1, 30, -1, -1)
Output: (20, 30, 20)

Example 5

Input: @ints = (-1, -1, 5, -1)
Output: (-1, -1, 5)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 2nd November
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
--]]
--# solution by pokgopun@gmail.com

--@params table{int}
function lv(ints) --@return table{int}
	seen = {} --table{int}
	ans = {} --table{int}
	x = 0
	for _, v in ipairs(ints) do
		if v == -1 then
			if x < #seen then
				table.insert(ans,seen[x+1])
			else
				table.insert(ans,-1)
			end
			x = x + 1
		else
			x = 0
			table.insert(seen,1,v)
		end
	end
	return ans
end

lu = require("luaunit")

function TestLv()
	for _, data in pairs({
		{ Input= {5, -1, -1}, Output= {5, -1}},
		{Input= {3, 7, -1, -1, -1}, Output= {7, 3, -1}},
		{Input= {2, -1, 4, -1, -1},Output= {2, 4, 2}},
		{Input= {10, 20, -1, 30, -1, -1}, Output= {20, 30, 20}},
		{Input= {-1, -1, 5, -1},Output= {-1, -1, 5}}}) do
		lu.assertEquals(lv(data.Input), data.Output)
	end
end

lu.run()
