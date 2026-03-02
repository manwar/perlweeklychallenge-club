--# https://theweeklychallenge.org/blog/perl-weekly-challenge-362/
--[[

Task 2: Spellbound Sorting

Submitted by: [46]Peter Campbell Smith
     __________________________________________________________________

   You are given an array of integers.

   Write a script to return them in alphabetical order, in any language of
   your choosing. Default language is English.

Example 1

Input: (6, 7, 8, 9 ,10)
Output: (8, 9, 7, 6, 10)

eight, nine, seven, six, ten

Example 2

Input: (-3, 0, 1000, 99)
Output: (-3, 99, 1000, 0)

minus three, ninety-nine, one thousand, zero

Example 3

Input: (1, 2, 3, 4, 5)

Output: (5, 2, 4, 3, 1) for French language
cinq, deux, quatre, trois, un

Output: (5, 4, 1, 3, 2) for English language
five, four, one, three, two

Example 4

Input: (0, -1, -2, -3, -4)
Output: (-4, -1, -3, -2, 0)

minus four, minus one, minus three, minus two, zero

Example 5

Input: (100, 101, 102)
Output: (100, 101, 102)

one hundred, one hundred and one, one hundred and two
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 1st March 2026.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
--]]
--# solution by pokgopun@gmail.com

local Processor = {
	l1={"zero","one","two","three","four","five","six","seven","eight","nine","ten","eleven","twelve"},
	l2={"twent","thirt","fort","fift","sixt","sevent","eight","ninet"},
	l3={"thousand","million","billion","trillion","quadrillion"},
}

function Processor:new(o)
	o = o or self
	setmetatable(o, self)
	self.__index = self
	return o
end

--@param int
function Processor:process(n) --@return string
	local res = ""
	if n < 0 then
		res = "minus "
		n = n * -1
	end
	if n < 13 then
		res = res .. self.l1[n+1]
	elseif n == 14 then
		res = res .. "fourteen"
	elseif n < 20 then
		res = res .. self.l2[n-11] .. "een"
	elseif n < 100 then
		res = res .. self.l2[(n//10)-1] .. "y"
		local d = n % 10
		if d > 0 then
			res = res .. "-" .. self.l1[d+1]
		end
	elseif n < 1000 then
		res = res .. self.l1[(n//100)+1] .. " hundred"
		local d = n % 100
		if d > 0 then
			res = res .. " and " .. self:process(d)
		end
	else
		local c, t, m = 0, 1, n
		while m >= 1000 do
			c = c + 1
			t = t * 1000
			m = m // 1000
		end
		res = res .. self:process(m) .. " " .. self.l3[c]
		local d = n % t
		if d > 0 then
			res = res .. (d < 100 and " and " or ", ") .. self:process(d)
		end
	end
	return res
end

--@param int table
local function spellboundSort(ints) --@return int table
	local res = {}
	table.move(ints, 1, #ints, 1, res)
	local pc = Processor:new()
	table.sort(res, function(a, b) return pc:process(a) < pc:process(b) end)
	return res
end

local lu = require("luaunit")

function TestSpellboundSort()
	local data = {
		{6, 7, 8, 9, 10}, {8, 9, 7, 6, 10},
		{-3, 0, 1000, 99}, {-3, 99, 1000, 0},
		{1, 2, 3, 4, 5}, {5, 4, 1, 3, 2},
		{0, -1, -2, -3, -4}, {-4, -1, -3, -2, 0},
		{100, 101, 102}, {100, 101, 102},
	}
	for i=2, #data, 2 do
		local inpt, otpt = data[i-1], data[i]
		lu.assertEquals(spellboundSort(inpt), otpt)
	end
end

lu.run()
