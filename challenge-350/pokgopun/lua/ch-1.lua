--# https://theweeklychallenge.org/blog/perl-weekly-challenge-350/
--[[

Task 1: Good Substrings

Submitted by: [51]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string.

   Write a script to return the number of good substrings of length three
   in the given string.

     A string is good if there are no repeated characters.

Example 1

Input: $str = "abcaefg"
Output: 5

Good substrings of length 3: abc, bca, cae, aef and efg

Example 2

Input: $str = "xyzzabc"
Output: 3

Good substrings of length 3: "xyz", "zab" and "abc"

Example 3

Input: $str = "aababc"
Output: 1

Good substrings of length 3: "abc"

Example 4

Input: $str = "qwerty"
Output: 4

Good substrings of length 3: "qwe", "wer", "ert" and "rty"

Example 5

Input: $str = "zzzaaa"
Output: 0

Task 2: Shuffle Pairs
--]]
--# solution by pokgopun@gmail.com

--@param str string
local function strIsUniq(str) --@return bool
	local tbl = {}
	for v in string.gmatch(str,".") do
		tbl[v] = (tbl[v] or 0) + 1
		if tbl[v] > 1 then
			return false
		end
	end
	return true
end

--@param str string
local function gs(str) --@return int
	local n = 3
	local l = #str - n + 1
	local c = 0
	for i=1, l do
		if strIsUniq(string.sub(str,i,i+2)) then
			c = c + 1
		end
	end
	return c
end

local lu = require("luaunit")
function TestGs()
	for inpt, otpt in pairs({
		abcaefg= 5,
		xyzzabc= 3,
		aababc= 1,
		qwerty= 4,
		zzzaaa= 0}) do
		lu.assertEquals(gs(inpt),otpt)
	end
end

lu.run()
