--# https://theweeklychallenge.org/blog/perl-weekly-challenge-345/
--[[

Task 1: Peak Positions

Submitted by: [43]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints.

   Find all the peaks in the array, a peak is an element that is strictly
   greater than its left and right neighbours. Return the indices of all
   such peak positions.

Example 1

Input: @ints = (1, 3, 2)
Output: (1)

Example 2

Input: @ints = (2, 4, 6, 5, 3)
Output: (2)

Example 3

Input: @ints = (1, 2, 3, 2, 4, 1)
Output: (2, 4)

Example 4

Input: @ints = (5, 3, 1)
Output: (0)

Example 5

Input: @ints = (1, 5, 1, 5, 1, 5, 1)
Output: (1, 3, 5)

Task 2: Last Visitor
--]]
--# solution by pokgopun@gmail.com

--@params table{int}
function pp(ints) --@return table{int}
	l = #ints
	if l == 0 then
		return {}
	elseif l == 1 then
		return {0}
	end
	i = 1
	p = {}
	while i <= l do
		if i == l then
			table.insert(p,i-1)
			break
		end
		if ints[i] < ints[i+1] then
			i = i + 1
		else
			if ints[i] > ints[i+1] then
				table.insert(p,i-1)
			end
			i = i + 2
			if i == l and ints[i] <= ints[i-1] then
				break
			end
		end
	end
	return p
end

lu = require("luaunit")

function TestPp()
	for _, data in pairs({
		{{1, 3, 2}, {1}},
		{{2, 4, 6, 5, 3}, {2}},
		{{1, 2, 3, 2, 4, 1}, {2, 4}},
		{{5, 3, 1}, {0}},
		{{1, 5, 1, 5, 1, 5, 1}, {1, 3, 5}}}) do
		lu.assertEquals(pp(data[1]),data[2])
	end
end

lu.run()
