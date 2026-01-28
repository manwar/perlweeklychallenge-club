--# https://theweeklychallenge.org/blog/perl-weekly-challenge-358/
--[[

Task 2: Encrypted String

Submitted by: [48]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string $str and an integer $int.

   Write a script to encrypt the string using the algorithm - for each
   character $char in $str, replace $char with the $int th character after
   $char in the alphabet, wrapping if needed and return the encrypted
   string.

Example 1

Input: $str = "abc", $int = 1
Output: "bcd"

Example 2

Input: $str = "xyz", $int = 2
Output: "zab"

Example 3

Input: $str = "abc", $int = 27
Output: "bcd"

Example 4

Input: $str = "hello", $int = 5
Output: "mjqqt"

Example 5

Input: $str = "perl", $int = 26
Output: "perl"
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 1st February
   2026.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
--]]
--# solution by pokgopun@gmail.com
--@param str string, n int
local function es(str, n) --@return string
	return string.gsub(str, ".", function(s)
		return string.char((((string.byte(s)-97)+(n%26))%26)+97)
	end)
end

local lu = require("luaunit")

function TestEs()
	local data = {
                "abc", 1, "bcd",
                "xyz", 2, "zab",
                "abc", 27, "bcd",
                "hello", 5, "mjqqt",
                "perl", 26, "perl",
	}
	for i=3, #data, 3 do
		local str, n, otpt = data[i-2], data[i-1], data[i]
		lu.assertEquals(es(str, n), otpt)
	end
end

lu.run()
