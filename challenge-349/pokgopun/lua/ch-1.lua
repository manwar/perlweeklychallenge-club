--# https://theweeklychallenge.org/blog/perl-weekly-challenge-349/
--[[

Task 1: Power String

Submitted by: [47]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string.

   Write a script to return the power of the given string.

     The power of the string is the maximum length of a non-empty
     substring that contains only one unique character.

Example 1

Input: $str = "textbook"
Output: 2

Breakdown: "t", "e", "x", "b", "oo", "k"
The longest substring with one unique character is "oo".

Example 2

Input: $str = "aaaaa"
Output: 5

Example 3

Input: $str = "hoorayyy"
Output: 3

Breakdown: "h", "oo", "r", "a", "yyy"
The longest substring with one unique character is "yyy".

Example 4

Input: $str = "x"
Output: 1

Example 5

Input: $str = "aabcccddeeffffghijjk"
Output: 4

Breakdown: "aa", "b", "ccc", "dd", "ee", "ffff", "g", "h", "i", "jj", "k"
The longest substring with one unique character is "ffff".

Task 2: Meeting Point
--]]
--# solution by pokgopun@gmail.com

--@param str string
local function ps(str) --@return int
	local prv = string.sub(str,1,1)
	local t = {[prv] = 1}
	local mx = 1
	for v in string.gmatch(string.sub(str,2),".") do
		t[v] = t[v] and t[v] + 1 or 1
		if v ~= prv then
			t[prv] = 0
			prv = v
		end
		if mx < t[v] then
			mx = t[v]
		end
	end
	return mx
end

local lu = require("luaunit")

function TestPs()
	for _, data in ipairs({
		{ Input=   "textbook",Output= 2},
		{Input=   "aaaaa",Output= 5},
		{Input=   "hoorayyy",Output= 3},
		{Input=   "x",Output= 1},
		{Input=   "aabcccddeeffffghijjk",Output= 4},
		{Input=   "aabcccddeeffzffghijjk",Output= 3}}) do
		lu.assertEquals(ps(data.Input), data.Output)
	end
end

lu.run()
