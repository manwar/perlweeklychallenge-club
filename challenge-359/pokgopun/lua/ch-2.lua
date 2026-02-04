--# https://theweeklychallenge.org/blog/perl-weekly-challenge-359/
--[[

Task 2: String Reduction

Submitted by: [46]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a word containing only alphabets,

   Write a function that repeatedly removes adjacent duplicate characters
   from a string until no adjacent duplicates remain and return the final
   word.

Example 1

Input: $word = "aabbccdd"
Output: ""

Iteration 1: remove "aa", "bb", "cc", "dd" => ""

Example 2

Input: $word = "abccba"
Output: ""

Iteration 1: remove "cc" => "abba"
Iteration 2: remove "bb" => "aa"
Iteration 3: remove "aa" => ""

Example 3

Input: $word = "abcdef"
Output: "abcdef"

No duplicate found.

Example 4

Input: $word = "aabbaeaccdd"
Output: "aea"

Iteration 1: remove "aa", "bb", "cc", "dd" => "aea"

Example 5

Input: $word = "mississippi"
Output: "m"

Iteration 1: Remove "ss", "ss", "pp" => "miiii"
Iteration 2: Remove "ii", "ii" => "m"
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 7th February
   2026.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
--]]
--# solution by pokgopun@gmail.com
--@param string
local function stringReduction(word) --@return string
	local l = word:len()
	repeat
		local d = l
		word = word:gsub("(.)%1", function(s)
			l = l - 2
			return ""
		end)
	until d == l
	return word
end

local lu = require("luaunit")

function TestStringReduction()
	local data = {
		"aabbccdd", "",
		"abccba", "",
		"abcdef", "abcdef",
		"aabbaeaccdd", "aea",
		"mississippi", "m",
	}
	local inpt, otpt
	for i=2, #data, 2 do
		inpt, otpt = data[i-1], data[i]
		--print(inpt, otpt)
		lu.assertEquals(stringReduction(inpt), otpt)
	end
end

lu.run()
