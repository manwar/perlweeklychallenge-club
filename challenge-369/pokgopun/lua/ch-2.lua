--# https://theweeklychallenge.org/blog/perl-weekly-challenge-369/
--[[

Task 2: Group Division

Submitted by: [64]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string, group size and filler character.

   Write a script to divide the string into groups of given size. In the
   last group if the string doesn’t have enough characters remaining fill
   with the given filler character.

Example 1

Input: $str = "RakuPerl", $size = 4, $filler = "*"
Output: ("Raku", "Perl")

Example 2

Input: $str = "Python", $size = 5, $filler = "0"
Output: ("Pytho", "n0000")

Example 3

Input: $str = "12345", $size = 3, $filler = "x"
Output: ("123", "45x")

Example 4

Input: $str = "HelloWorld", $size = 3, $filler = "_"
Output: ("Hel", "loW", "orl", "d__")

Example 5

Input: $str = "AI", $size = 5, $filler = "!"
Output: "AI!!!"
     __________________________________________________________________

   By submitting a response to the challenge you agree that your name or
   pseudonym, any photograph you supply and any other personal information
   contained in your submission may be published on this website and the
   associated mobile app. Last date to submit the solution 23:59 (UK Time)
]]
--# solution by pokgopun@gmail.com

--@param string, int, string
local function gd(str, size, filler) --@return strings table
	local o = (size - (#str % size)) % size
	if o > 0 then
		str = str .. string.rep(filler, o)
	end
	local s = {}
	for j = size, #str, size do
		table.insert(s, str:sub(1 + j - size, j)) 
	end
	--print(table.unpack(s))
	return s
end

local lu = require("luaunit")

function TestGd()
	local data = {
		"RakuPerl", 4, "*" , {"Raku", "Perl"} ,
		"Python", 5, "0" , {"Pytho", "n0000"} ,
		"12345", 3, "x" , {"123", "45x"} ,
		"HelloWorld", 3, "_" , {"Hel", "loW", "orl", "d__"} ,
		"AI", 5, "!", {"AI!!!"} ,
	}
	for i=4, #data, 4 do
		local str, size, filler, otpt = data[i-3], data[i-2], data[i-1], data[i]
		lu.assertEquals(gd(str, size, filler), otpt)
	end
end

lu.run()
