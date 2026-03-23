--# https://theweeklychallenge.org/blog/perl-weekly-challenge-366/
--[[

Task 1: Count Prefixes

Submitted by: [67]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of words and a string (contains only lowercase
   English letters).

   Write a script to return the number of words in the given array that
   are a prefix of the given string.

Example 1

Input: @array = ("a", "ap", "app", "apple", "banana"), $str = "apple"
Output: 4

Example 2

Input: @array = ("cat", "dog", "fish"), $str = "bird"
Output: 0

Example 3

Input: @array = ("hello", "he", "hell", "heaven", "he"), $str = "hello"
Output: 4

Example 4

Input: @array = ("", "code", "coding", "cod"), $str = "coding"
Output: 3

Example 5

Input: @array = ("p", "pr", "pro", "prog", "progr", "progra", "program"), $str =
 "program"
Output: 7

Task 2: Valid Times
]]
--# solution by pokgopun@gmail.com

--@param strings table, string
local function countPrefixes(strings, str) --@return int
	local c = 0
	for _, v in ipairs(strings) do
		if str:find(v) == 1 then
			c = c + 1
		end
	end
	return c
end

local lu = require("luaunit")

function TestCountPrefixes()
	local data =  {
		{"a", "ap", "app", "apple", "banana"}, "apple" , 4 , 
		{"cat", "dog", "fish"}, "bird" , 0 , 
		{"hello", "he", "hell", "heaven", "he"}, "hello" , 4 , 
		{"", "code", "coding", "cod"}, "coding" , 3 , 
		{"p", "pr", "pro", "prog", "progr", "progra", "program"}, "program" , 7,
	}
	for i=3, #data, 3 do
		local strings, str, output = data[i-2], data[i-1], data[i]
		lu.assertEquals(countPrefixes(strings, str), output)
	end
end

lu.run()
