#!/usr/bin/env lua5.4
--# https://theweeklychallenge.org/blog/perl-weekly-challenge-343/
--[[

Task 1: Zero Friend

Submitted by: [39]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a list of numbers.

   Find the number that is closest to zero and return its distance to
   zero.

Example 1

Input: @nums = (4, 2, -1, 3, -2)
Output: 1

Values closest to 0: -1 and 2 (distance = 1)

Example 2

Input: @nums = (-5, 5, -3, 3, -1, 1)
Output: 1

Values closest to 0: -1 and 1 (distance = 1)

Example 3

Input: @ums = (7, -3, 0, 2, -8)
Output: 0

Values closest to 0: 0 (distance = 0)
Exact zero wins regardless of other close values.

Example 4

Input: @nums = (-2, -5, -1, -8)
Output: 1

Values closest to 0: -1 and -2 (distance = 1 and 2)

Example 5

Input: @nums = (-2, 2, -4, 4, -1, 1)
Output: 1

Values closest to 0: -1 and 1 (distance = 1)

Task 2: Champion Team
--]]
--# solution by pokgopun@gmail.com

local function zf(nums)
	local mn = 0
	for i, v in ipairs(nums) do
		if i == 1 then
			if v == 0 then
				return 0
			elseif v < 0 then
				mn = -v
			else
				mn = v
			end
		else
			if v == 0 then
				return 0
			elseif v < 0 then
				v = -v
			end
			if mn > v then
				mn = v
			end
		end
	end
	return mn
end

local lu = require("luaunit")

function TestZf()
	for _, data in ipairs({
		{Input = {4, 2, -1, 3, -2},Output= 1},
		{Input = {-5, 5, -3, 3, -1, 1},Output= 1},
		{Input = {7, -3, 0, 2, -8},Output= 0},
		{Input = {-2, -5, -1, -8},Output= 1},
		{Input = {-2, 2, -4, 4, -1, 1},Output= 1}}) do
		--print(table.concat(data.Input," ") .. " : " .. data.Output)
		lu.assertEquals(zf(data.Input),data.Output)
	end
end

lu.run()
