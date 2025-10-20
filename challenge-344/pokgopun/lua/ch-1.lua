#!/usr/bin/env lua5.4
--# https://theweeklychallenge.org/blog/perl-weekly-challenge-344/
--[[

Task 1: Array Form Compute

Submitted by: [43]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints and an integer, $x.

   Write a script to add $x to the integer in the array-form.

     The array form of an integer is a digit-by-digit representation
     stored as an array, where the most significant digit is at the 0th
     index.

Example 1

Input: @ints = (1, 2, 3, 4), $x = 12
Output: (1, 2, 4, 6)

Example 2

Input: @ints = (2, 7, 4), $x = 181
Output: (4, 5, 5)

Example 3

Input: @ints = (9, 9, 9), $x = 1
Output: (1, 0, 0, 0)

Example 4

Input: @ints = (1, 0, 0, 0, 0), $x = 9999
Output: (1, 9, 9, 9, 9)

Example 5

Input: @ints = (0), $x = 1000
Output: (1, 0, 0, 0)

Task 2: Array Formation
--]]
--# solution by pokgopun@gmail.com

--@params {int}
function nums2num(nums) --@return int
	local t = 1
	local num = 0
	for i=#nums,1,-1 do
		num = num + t * nums[i]
		t = t * 10
	end
	return num
end

--@params int
function num2nums(num) --@return {int}
	local nums = {}
	while num > 0 do
		table.insert(nums, 1, num % 10)
		num = (num- nums[1])/10
	end
	return nums
end

--@params {int}, {int}
function compare_nums(nums1,nums2) --@return bool
	for i=1,#nums1 do
		if nums1[i] ~= nums2[i] then
			return false
		end
	end
	return true
end

--@params {int}, int
function afc(nums, n) --@return {int}
	return num2nums(nums2num(nums)+n)
end

local lu = require("luaunit")

function TestAfc()
	for _, data in ipairs({
		{ints = {1, 2, 3, 4}, x = 12, Output= {1, 2, 4, 6}},
		{ints = {2, 7, 4}, x = 181, Output= {4, 5, 5}},
		{ints = {9, 9, 9}, x = 1, Output= {1, 0, 0, 0}},
		{ints = {1, 0, 0, 0, 0}, x = 9999, Output= {1, 9, 9, 9, 9}},
		{ints = {0}, x = 1000,Output= {1, 0, 0, 0}}}) do
		lu.assertEquals(afc(data.ints,data.x),data.Output)
	end
end

lu.run()
