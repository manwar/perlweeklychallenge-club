#!/usr/bin/env lua5.4
--# https://theweeklychallenge.org/blog/perl-weekly-challenge-344/
--[[

Task 2: Array Formation

Submitted by: [44]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given two list: @source and @target.

   Write a script to see if you can build the exact @target by putting
   these smaller lists from @source together in some order. You cannot
   break apart or change the order inside any of the smaller lists in
   @source.

Example 1

Input: @source = ([2,3], [1], [4])
       @target = (1, 2, 3, 4)
Output: true

Use in the order: [1], [2,3], [4]

Example 2

Input: @source = ([1,3], [2,4])
       @target = (1, 2, 3, 4)
Output: false

Example 3

Input: @source = ([9,1], [5,8], [2])
       @target = (5, 8, 2, 9, 1)
Output: true

Use in the order: [5,8], [2], [9,1]

Example 4

Input: @source = ([1], [3])
       @target = (1, 2, 3)
Output: false

Missing number: 2

Example 5

Input: @source = ([7,4,6])
       @target = (7, 4, 6)
Output: true

Use in the order: [7, 4, 6]
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 26th October
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
--]]
--# solution by pokgopun@gmail.com

--@params {int}, {int}
function compare_nums(nums1,nums2) --@return bool
	for i=1,#nums1 do
		if nums1[i] ~= nums2[i] then
			return false
		end
	end
	return true
end

--@params {{type}}, int
function permgen(a, n)
	n = n or #a
	if n == 0 then
		coroutine.yield(a)
	else
		for i = 1, n do
			a[n], a[i] = a[i], a[n] -- Swap elements
			permgen(a, n - 1)
			a[n], a[i] = a[i], a[n] -- Backtrack (swap back)
		end
	end
end

--@params {{int}}, {int}
function af(source, target) --@return bool, error
	local co = coroutine.create(function() permgen(source) end)
	while true do
		local status, p = coroutine.resume(co)
		if not status then
			return nil, "Error: "..p
		end
		if p then
			local t = {}
			local i = 1
			for _, ints in ipairs(p) do
				local l = #ints
				table.move(ints,1,l,i,t)
				i = i + l
			end
			if compare_nums(target,t) then
				return true
			end
		else
			break -- No more permutations
		end
	end
	return false
end

local lu = require("luaunit")

function TestAf()
	for _, data in ipairs({
		{source = {{2,3}, {1}, {4}},target = {1, 2, 3, 4},Output= true},
		{source = {{1,3}, {2,4}},target = {1, 2, 3, 4},Output= false},
		{source = {{9,1}, {5,8}, {2}},target = {5, 8, 2, 9, 1},Output= true},
		{source = {{1}, {3}},target = {1, 2, 3},Output= false},
		{source = {{7,4,6}},target = {7, 4, 6},Output= true}}) do
		lu.assertEquals(af(data.source,data.target), data.Output)
	end
end

lu.run()
