#!/usr/bin/env lua5.3

--# https://theweeklychallenge.org/blog/perl-weekly-challenge-350/
--[[

Task 2: Shuffle Pairs

Submitted by: [52]E. Choroba
     __________________________________________________________________

   If two integers A <= B have the same digits but in different orders, we
   say that they belong to the same shuffle pair if and only if there is
   an integer k such that A = B * k. k is called the witness of the pair.

   For example, 1359 and 9513 belong to the same shuffle pair, because
   1359 * 7 = 9513.

   Interestingly, some integers belong to several different shuffle pairs.
   For example, 123876 forms one shuffle pair with 371628, and another
   with 867132, as 123876 * 3 = 371628, and 123876 * 7 = 867132.

   Write a function that for a given $from, $to, and $count returns the
   number of integers $i in the range $from <= $i <= $to that belong to at
   least $count different shuffle pairs.

   PS: Inspired by a conversation between Mark Dominus and Simon Tatham at
   Mastodon.

Example 1

Input: $from = 1, $to = 1000, $count = 1
Output: 0

There are no shuffle pairs with elements less than 1000.

Example 2

Input: $from = 1500, $to = 2500, $count = 1
Output: 3

There are 3 integers between 1500 and 2500 that belong to shuffle pairs.

1782, the other element is 7128 (witness 4)
2178, the other element is 8712 (witness 4)
2475, the other element is 7425 (witness 3)

Example 3

Input: $from = 1_000_000, $to = 1_500_000, $count = 5
Output: 2

There are 2 integers in the given range that belong to 5 different shuffle pairs
.

1428570 pairs with 2857140, 4285710, 5714280, 7142850, and 8571420
1429857 pairs with 2859714, 4289571, 5719428, 7149285, and 8579142

The witnesses are 2, 3, 4, 5, and 6 for both the integers.

Example 4

Input: $from = 13_427_000, $to = 14_100_000, $count = 2
Output: 11

6 integers in the given range belong to 3 different shuffle pairs, 5 integers be
long to 2 different ones.

Example 5

Input: $from = 1030, $to = 1130, $count = 1
Output: 2

There are 2 integers between 1020 and 1120 that belong to at least one shuffle p
air:
1035, the other element is 3105 (witness k = 3)
1089, the other element is 9801 (witness k = 9)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 7th December
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
--]]
--# solution by pokgopun@gmail.com

--@param tbl table, n int
local function setDgt(tbl, n)
	while n > 0 do
		local idx = n % 10
		tbl[idx] = (tbl[idx] or 0) + 1
		n = n // 10
	end
end

--@param tbl table, n int
local function clrDgt(tbl, n)
	for k in pairs(tbl) do
		tbl[k] = nil
	end
end

local function chkDgt(tbl)
	for k, v in pairs(tbl) do
		print(k,":",v)
	end
end

--@param tbl1 table, tbl2 table
local function dgtEqual(tbl1, tbl2) --@return bool
	--chkDgt(tbl1)
	--chkDgt(tbl2)
	if #tbl1 ~= #tbl2 then
		return false
	end
	for k, v in pairs(tbl1) do
		if tbl2[k] ~= v then
			return false
		end
	end
	return true
end

-- class for solving the challenge by calling
local Processor = {
	sep = string.rep("#",10),
	s = {},
	t = {}
}

function Processor:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

--@param from int, to int, count int
function Processor:process(from, to, count) --@return int
	local c = 0
	for n=from, to do
		if self:isShufflePair(n, count) then
			c = c + 1
		end
	end
	return c
end

--@param n int, count int
function Processor:isShufflePair(n, count) --@return bool
	setDgt(self.s, n)
	local tbl = {}
	for k, v in pairs(self.s) do
		table.insert(tbl, string.rep(k,v))
	end
	table.sort(tbl, function (a,b) return a > b end)
	local lmt = table.concat(tbl)
	local l = lmt // n
	local m = n
	local c = 0
	--print(n,lmt,l,count - c)
	while l > count - c do
		l = l - 1
		m = m + n
		setDgt(self.t, m)
		--print(self.sep,m,self.sep)
		--print(self.sep,n,self.sep)
		if dgtEqual(self.t, self.s) then
			--print("yeah")
			--[[
			print(self.sep,m,self.sep)
			chkDgt(self.t)
			print(self.sep,n,self.sep)
			chkDgt(self.s)
		--]]
			c = c + 1
		end
		clrDgt(self.t)
		if c == count then
			clrDgt(self.s)
			return true
		end
	end
	clrDgt(self.s)
	return false
end

local lu = require("luaunit")

function TestSp()
	local p = Processor:new()
	for _, data in ipairs({
		{from = 1, to = 1000, count = 1,Output= 0},
		{from = 1500, to = 2500, count = 1,Output= 3},
		{from = 1000000, to = 1500000, count = 5,Output= 2},
		{from = 13427000, to = 14100000, count = 2,Output= 11},
		{from = 1030, to = 1130, count = 1,Output= 2}}) do --this small one after the huge one does trigger a bug in lua5.4, need to move it up or use lua5.3 which is slower
		--print(data.from,data.to,data.count,data.Output)
		--lu.assertEquals(sp(data.from,data.to,data.count),data.Output)
		lu.assertEquals(p:process(data.from,data.to,data.count),data.Output)
	end
end

lu.run()
