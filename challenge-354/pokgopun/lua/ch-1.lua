--# https://theweeklychallenge.org/blog/perl-weekly-challenge-354/
--[[

Task 1: Min Abs Diff

Submitted by: [72]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of distinct integers.

   Write a script to find all pairs of elements with the minimum absolute
   difference.
Rules (a,b):
1: a, b are from the given array.
2: a < b
3: b - a = min abs diff any two elements in the given array

Example 1

Input: @ints= (4, 2, 1, 3)
Output: [1, 2], [2, 3], [3, 4]

Example 2

Input: @ints = (10, 100, 20, 30)
Output: [10, 20], [20, 30]

Example 3

Input: @ints = (-5, -2, 0, 3)
Output: [-2, 0]

Example 4

Input: @ints = (8, 1, 15, 3)
Output: [1, 3]

Example 5

Input: @ints = (12, 5, 9, 1, 15)
Output: [9, 12], [12, 15]

Task 2: Shift Grid
--]]
--# solution by pokgopun@gmail.com

--@param ints "table of int"
local function mad(ints) --@return ps "table of table of two ints"
	table.sort(ints)
	local mn = ints[#ints] - ints[1]
	local ps = {}
	for i=1, #ints - 1 do
		local a, b = ints[i], ints[i+1]
		local d = b - a
		if mn == d then
			table.insert(ps,{a,b})
		elseif mn > d then
			mn = d
			ps = {{a,b}}
		end
	end
	return ps
end

local lu = require("luaunit")

function TestMad()
	for _, data in ipairs({
		{Input = {4, 2, 1, 3},Output={ {1, 2}, {2, 3}, {3, 4}}},
		{Input = {10, 100, 20, 30},Output={ {10, 20}, {20, 30}}},
		{Input = {-5, -2, 0, 3},Output={ {-2, 0}}},
		{Input = {8, 1, 15, 3},Output={ {1, 3}}},
		{Input = {12, 5, 9, 1, 15},Output={ {9, 12}, {12, 15}}}}) do
		lu.assertEquals(mad(data.Input), data.Output)
	end
end

lu.run()
