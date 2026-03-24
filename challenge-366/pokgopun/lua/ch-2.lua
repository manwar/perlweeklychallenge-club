--# https://theweeklychallenge.org/blog/perl-weekly-challenge-366/
--[[

Task 2: Valid Times

Submitted by: [68]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a time in the form ‘HH:MM’. The earliest possible time is
   ‘00:00’ and the latest possible time is ‘23:59’. In the string time,
   the digits represented by the ‘?’ symbol are unknown, and must be
   replaced with a digit from 0 to 9.

   Write a script to return the count different ways we can make it a
   valid time.

Example 1

Input: $time = "?2:34"
Output: 3

0 -> "02:34" valid
1 -> "12:34" valid
2 -> "22:34" valid

Example 2

Input: $time = "?4:?0"
Output: 12

Hours: tens digit ?, ones digit 4 -> can be 04, and 14 (2 possibilities)
Minutes: tens digit ?, ones digit 0 -> tens can be 0-5 (6 possibilities)

Total: 2 × 6 = 12

Example 3

Input: $time = "??:??"
Output: 1440

Hours: from 00 to 23 -> 24 possibilities
Minutes: from 00 to 59 -> 60 possibilities

Total: 24 × 60 = 1440

Example 4

Input: $time = "?3:45"
Output: 3

If tens digit is 0 or 1 -> any ones digit works, so 03 and 13 are valid
If tens digit is 2 -> ones digit must be 0-3, but here ones digit is 3, so 23 is
 valid

Therefore: 0,1,2 are all valid -> 3 possibilities

Example 5

Input: $time = "2?:15"
Output: 4

Tens digit is 2, so hours can be 20-23
Ones digit can be 0,1,2,3 (4 possibilities)

Therefore: 4 valid times
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 29th March
]]
--# solution by pokgopun@gmail.com

--@param string
local function validTimes(time) --@return int
	--@param int, int, int
	local function f(ts, d0, d1) --@return int
	--local f = function(ts, d0, d1) --this style also works
		local wc = string.byte("?") - 48
		local w0, w1 = d0 == wc, d1 == wc
		local c = 0
		if not w0 and not w1 then
			c = 1
		elseif w0 and w1 then
			c = ts 
		else
			for t=0, ts-1 do
				if (w0 or d0 == t//10) and (w1 or d1 == t%10) then
					c = c + 1
				end
			end
		end
		return c
	end
	h0, h1, _, m0, m1 = time:byte(1, #time)
	return f(24, h0 - 48, h1 - 48) * f(60, m0 - 48, m1 - 48)
end

local lu = require("luaunit")

function TestValidTimes()
	local data = {
		"?2:34" , 3 ,
		"?4:?0" , 12 ,
		"??:??" , 1440 ,
		"?3:45" , 3,
		"2?:15" , 4,
	}
	for i=2, #data, 2 do
		local inpt, otpt = data[i-1], data[i]
		lu.assertEquals(validTimes(inpt), otpt)
	end
end

lu.run()
