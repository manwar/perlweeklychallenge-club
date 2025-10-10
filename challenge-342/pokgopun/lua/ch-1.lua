--# https://theweeklychallenge.org/blog/perl-weekly-challenge-342/
--[[

Task 1: Balance String

Submitted by: [46]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string made up of lowercase English letters and digits
   only.

   Write a script to format the give string where no letter is followed by
   another letter and no digit is followed by another digit. If there are
   multiple valid rearrangements, always return the lexicographically
   smallest one. Return empty string if it is impossible to format the
   string.

Example 1

Input: $str = "a0b1c2"
Output: "0a1b2c"

Example 2

Input: $str = "abc12"
Output: "a1b2c"

Example 3

Input: $str = "0a2b1c3"
Output: "0a1b2c3"

Example 4

Input: $str = "1a23"
Output: ""

Example 5

Input: $str = "ab123"
Output: "1a2b3"

Task 2: Max Score
--]]
--# solution by pokgopun@gmail.com

--[[
local Strings = {}

--@param o table of string
--@return Strings
--function Strings:New(strings)
function Strings:New(o)
	local o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

--@param str string
--@param pattern string
--@return Strings
function Strings:FromString(str, pattern)
	local pattern = pattern or "."
	local o = self:New()
	str:gsub(
		pattern,
		function (e)
			table.insert(o,e)
		end)
	return o
end

--@param str string
--@return number
function Strings:Index(str)
	for i, v in ipairs(self) do
		if v == str then
			return i
		end
	end
	return -1
end
--]]

--@param str string
--@return string
function bs(str)
	--[[ this part of solution needs the above implemented Strings class
	local s = Strings:FromString(str .. "_")
	table.sort(s)
	local m = s:Index("_")
	--]]
	---[[ this part of solution trade come with overhead on using string.find/table.concat but does not require the Strings class
	local s = {}
	string.gsub(str .. "_", ".", function (e) table.insert(s,e) end)
	table.sort(s) 
	local m = string.find(table.concat(s,""),"_")
	--]]
	local l = #s
	local d = l - m - ( m - 1)
	if d == 0 or d == -1 then
		table.move(s,m+1,l,m,s)
	elseif d == 1 then
		for i=1, m do
			s[i], s[i+m] = s[i+m], s[i]
		end
	else
		return ""
	end
	local n = math.max(m,m+d) - 1
	for i=2, n do
		for j=i, n do
			s[j], s[n+j-i+1] = s[n+j-i+1], s[j]
		end
	end
	s[#s] = nil
	return table.concat(s)
end

local lu = require("luaunit")

function TestBs()
	for _, data in ipairs({
		{Input= "a0b1c2",Output= "0a1b2c"},
		{Input= "abc12",Output= "a1b2c"},
		{Input= "0a2b1c3",Output= "0a1b2c3"},
		{Input= "1a23",Output= ""},
		{Input= "ab123",Output= "1a2b3"}}) do
		lu.assertEquals(bs(data.Input),data.Output)
	end
end

lu.run()
