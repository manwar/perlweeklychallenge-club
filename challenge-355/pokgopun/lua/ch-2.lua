--# https://theweeklychallenge.org/blog/perl-weekly-challenge-355/
--[[

Task 2: Mountain Array

Submitted by: [49]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints.

   Write a script to return true if the given array is a valid mountain
   array.
An array is mountain if and only if:
1) arr.length >= 3
and
2) There exists some i with 0 < i < arr.length - 1 such that:
arr[0] < arr[1]     < ... < arr[i - 1] < arr[i]
arr[i] > arr[i + 1] > ... > arr[arr.length - 1]

Example 1

Input: @ints = (1, 2, 3, 4, 5)
Output: false

Example 2

Input: @ints = (0, 2, 4, 6, 4, 2, 0)
Output: true

Example 3

Input: @ints = (5, 4, 3, 2, 1)
Output: false

Example 4

Input: @ints = (1, 3, 5, 5, 4, 2)
Output: false

Example 5

Input: @ints = (1, 3, 2)
Output: true
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 11th January
   2026.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
--]]
--# solution by pokgopun@gmail.com

--@param ints table
local function ma(ints) --@return bool
	local mx = {}
	for i, v in ipairs(ints) do
		if #mx == 0 then
			mx = {i, v, 1}
		elseif mx[2] == v then
			mx[3] = mx[3] + 1
		elseif mx[2] < v then
			mx[1] = i
			mx[2] = v
			mx[3] = 1
		end
	end
	return mx[3] == 1 and mx[1] ~= 1 and mx[1] ~= #ints
end

local lu = require("luaunit")

function TestMa()
	local data = {
		{1, 2, 3, 4, 5}, false,
		{0, 2, 4, 6, 4, 2, 0}, true,
		{5, 4, 3, 2, 1}, false,
		{1, 3, 5, 5, 4, 2}, false,
		{1, 3, 2}, true
	}
	local inpt, otpt
	for i=2, #data, 2 do
		inpt, otpt = data[i-1], data[i]
		lu.assertEquals(ma(inpt), otpt)
	end
end

lu.run()
