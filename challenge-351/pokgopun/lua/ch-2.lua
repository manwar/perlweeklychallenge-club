--# https://theweeklychallenge.org/blog/perl-weekly-challenge-351/
--[[

Task 2: Arithmetic Progression

Submitted by: [56]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of numbers.

   Write a script to return true if the given array can be re-arranged to
   form an arithmetic progression, otherwise return false.

     A sequence of numbers is called an arithmetic progression if the
     difference between any two consecutive elements is the same.

Example 1

Input: @num = (1, 3, 5, 7, 9)
Output: true

Already AP with common difference 2.

Example 2

Input: @num = (9, 1, 7, 5, 3)
Output: true

The given array re-arranged like (1, 3, 5, 7, 9) with common difference 2.

Example 3

Input: @num = (1, 2, 4, 8, 16)
Output: false

This is geometric progression and not arithmetic progression.

Example 4

Input: @num = (5, -1, 3, 1, -3)
Output: true

The given array re-arranged like (-3, -1, 1, 3, 5) with common difference 2.

Example 5

Input: @num = (1.5, 3, 0, 4.5, 6)
Output: true

The given array re-arranged like (0, 1.5, 3, 4.5, 6) with common difference 1.5.
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 14th December
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
--]]
--# solution by pokgopun@gmail.com

--@param num table
local function ap(num) --@return bool
	l = #num
	if l < 3 then
		return true
	end
	table.sort(num)
	step = (num[l] - num[1])/(l-1)
	while l > 1 do
		if num[l] ~= num[l-1] + step then
			return  false
		end
		l = l - 1
	end
	return true
end

local lu = require("luaunit")

function testAp()
	for _, data in ipairs({
		{ Input = {1, 3, 5, 7, 9},Output= true},
		{Input = {9, 1, 7, 5, 3},Output= true},
		{Input = {1, 2, 4, 8, 16},Output= false},
		{Input = {5, -1, 3, 1, -3},Output= true},
		{Input = {1.5, 3, 0, 4.5, 6},Output= true}}) do
		lu.assertEquals(ap(data.Input),data.Output)
	end
end

lu.run()
