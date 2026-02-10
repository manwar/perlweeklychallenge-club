--# https://theweeklychallenge.org/blog/perl-weekly-challenge-360/
--[[

Task 2: Word Sorter

Submitted by: [47]Mohammad Sajid Anwar
     __________________________________________________________________

   You are give a sentence.

   Write a script to order words in the given sentence alphabetically but
   keeps the words themselves unchanged.

Example 1

Input: $str = "The quick brown fox"
Output: "brown fox quick The"

Example 2

Input: $str = "Hello    World!   How   are you?"
Output: "are Hello How World! you?"

Example 3

Input: $str = "Hello"
Output: "Hello"

Example 4

Input: $str = "Hello, World! How are you?"
Output: "are Hello, How World! you?"

Example 5

Input: $str = "I have 2 apples and 3 bananas!"
Output: "2 3 and apples bananas! have I"
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 14th February
   2026.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
--]]
--# solution by pokgopun@gmail.com

--@param string
local function wordSorter(str) --@return string
	local words = {}
	for v in str:gmatch("%S+") do
		table.insert(words,v)
	end
	table.sort(words, function(a, b)
		return string.lower(a) < string.lower(b)
	end)
	return table.concat(words, " ")
end

local lu = require("luaunit")

function TestWordSorter()
	local data = {
		"The quick brown fox", "brown fox quick The",
		"Hello    World!   How   are you?", "are Hello How World! you?",
		"Hello", "Hello",
		"Hello, World! How are you?", "are Hello, How World! you?",
		"I have 2 apples and 3 bananas!", "2 3 and apples bananas! have I",
	}
	for i=2, #data, 2 do
		local inpt, otpt = data[i-1], data[i]
		lu.assertEquals(wordSorter(inpt), otpt)
	end
end

lu.run()
