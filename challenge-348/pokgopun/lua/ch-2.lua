--# https://theweeklychallenge.org/blog/perl-weekly-challenge-348/
--[[

Task 2: Covert Time

Submitted by: [50]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given two strings, $source and $target, containing time in
   24-hour time form.

   Write a script to convert the source into target by performing one of
   the following operations:
1. Add  1 minute
2. Add  5 minutes
3. Add 15 minutes
4. Add 60 minutes

   Find the total operations needed to get to the target.

Example 1

Input: $source = "02:30"
       $target = "02:45"
Output: 1

Just one operation i.e. "Add 15 minutes".

Example 2

Input: $source = "11:55"
       $target = "12:15"
Output: 2

Two operations i.e. "Add 15 minutes" followed by "Add 5 minutes".

Example 3

Input: $source = "09:00"
       $target = "13:00"
Output: 4

Four operations of "Add 60 minutes".

Example 4

Input: $source = "23:45"
       $target = "00:30"
Output: 3

Three operations of "Add 15 minutes".

Example 5

Input: $source = "14:20"
       $target = "15:25"
Output: 2

Two operations, one "Add 60 minutes" and one "Add 5 minutes"
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 23rd November
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
--]]
--# solution by pokgopun@gmail.com

local function helper(timestr)
	local m = 0
	local h2m = true
	for t in string.gmatch(timestr,"%d+") do
		t = tonumber(t)
		if h2m then
			t = t * 60
			h2m = false
		end
		m = m + t
	end
	return m
end

--@params string, string
local function ct(source, target) --@return integer
	local m1 = helper(source)
	local m2 = helper(target)
	if m2 < m1 then
		m2 = m2 + 24*60
	end
	m = m2 - m1
	c = 0
	for _, n in ipairs({60, 15, 5}) do
		c = c + m // n
		m = m % n
	end
	--print(source, target, m1, m2, m + c)
	return c + m
end

local lu = require("luaunit")

function TestCt()
	for _, data in ipairs({
		{source = "02:30",target = "02:45", Output= 1},
		{source = "11:55",target = "12:15",Output= 2},
		{source = "09:00",target = "13:00",Output= 4},
		{source = "23:45",target = "00:30",Output= 3},
		{source = "14:20",target = "15:25",Output= 2}}) do
		lu.assertEquals(ct(data.source,data.target), data.Output)
	end
end

lu.run()
