--# https://theweeklychallenge.org/blog/perl-weekly-challenge-367/
--[[

Task 2: Conflict Events

Submitted by: [62]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given two events start and end time.

   Write a script to find out if there is a conflict between the two
   events. A conflict happens when two events have some non-empty
   intersection.

Example 1

Input: @event1 = ("10:00", "12:00")
       @event2 = ("11:00", "13:00")
Output: true

Both events overlap from "11:00" to "12:00".

Example 2

Input: @event1 = ("09:00", "10:30")
       @event2 = ("10:30", "12:00")
Output: false

Event1 ends exactly at 10:30 when Event2 starts.
Since the problem defines intersection as non-empty, exact boundaries touching i
s not a conflict.

Example 3

Input: @event1 = ("14:00", "15:30")
       @event2 = ("14:30", "16:00")
Output: true

Both events overlap from 14:30 to 15:30.

Example 4

Input: @event1 = ("08:00", "09:00")
       @event2 = ("09:01", "10:00")
Output: false

There is a 1-minute gap from "09:00" to "09:01".

Example 5

Input: @event1 = ("23:30", "00:30")
       @event2 = ("00:00", "01:00")
Output: true

They overlap from "00:00" to "00:30".
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 5th April 2026.
]]
--# solution by pokgopun@gmail.com

--@param string
local function t2e(time) --@return int
	local h, m = time:match("(%d+):(%d+)")
	return h * 60 + m
end

--@param table
local function r2ab(times) --@return int, int
	local a, b = t2e(times[1]), t2e(times[2])
	local c = 24 * 60
	if a > b then
		a = a - c
	end
	return a, b
end

--@param table, table
local function ce(times1, times2) --@return bool
	local e1a, e1b = r2ab(times1)
	local e2a, e2b = r2ab(times2)
	return not ((e2a <= e1a or e2a >= e1b) and (e2b <= e1a or e2b >= e1b))
end

local lu = require("luaunit")

function TestCe()
	local data = {
		{"10:00", "12:00"} , {"11:00", "13:00"} , true ,
		{"09:00", "10:30"} , {"10:30", "12:00"} , false ,
		{"14:00", "15:30"} , {"14:30", "16:00"} , true ,
		{"08:00", "09:00"} , {"09:01", "10:00"} , false ,
		{"23:30", "00:30"} , {"00:00", "01:00"} , true,
	}
	for i=3, #data, 3 do
		local event1, event2, otpt = data[i-2], data[i-1], data[i]
		lu.assertEquals(ce(event1, event2), otpt)
	end
end

lu.run()
