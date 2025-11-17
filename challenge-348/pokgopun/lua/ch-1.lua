--# https://theweeklychallenge.org/blog/perl-weekly-challenge-348/
--[[

Task 1: String Alike

Submitted by: [49]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string of even length.

   Write a script to find if the given string split into two halves of
   equal lengths and they both have same number of vowels.

Example 1

Input: $str = "textbook"
Output: false

1st half: "text" (1 vowel)
2nd half: "book" (2 vowels)

Example 2

Input: $str = "book"
Output: true

1st half: "bo" (1 vowel)
2nd half: "ok" (1 vowel)

Example 3

Input: $str = "AbCdEfGh"
Output: true

1st half: "AbCd" (1 vowel)
2nd half: "EfGh" (1 vowel)

Example 4

Input: $str = "rhythmmyth"
Output: false

1st half: "rhyth" (0 vowel)
2nd half: "mmyth" (0 vowel)

Example 5

Input: $str = "UmpireeAudio"
Output: false

1st half: "Umpire" (3 vowels)
2nd half: "eAudio" (5 vowels)

Task 2: Covert Time
--]]
--# solution by pokgopun@gmail.com

--@params string
local function sa(str) --@return bool
	str = string.lower(str)
	local vwl = "aeiou"
	local cnt1 = 0
	for i=1,#str/2 do
		if string.match(vwl,string.sub(str,i,i)) then
			cnt1 = cnt1 + 1
		end
	end
	local cnt2 = 0
	for i=1+#str/2,#str do
		if string.match(vwl,string.sub(str,i,i)) then
			cnt2 = cnt2 + 1
		end
	end
	return cnt1 > 0 and cnt1 == cnt2
end

local lu = require("luaunit")

function TestSa()
	for inpt, otpt in pairs({
		["textbook"]= false,
		["book"]= true,
		["AbCdEfGh"]= true,
		["rhythmmyth"]= false,
		["UmpireeAudio"]= false}) do
		lu.assertEquals(sa(inpt),otpt)
	end
end

lu.run()
