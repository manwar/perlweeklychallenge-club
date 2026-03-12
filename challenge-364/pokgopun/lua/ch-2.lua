--# https://theweeklychallenge.org/blog/perl-weekly-challenge-364/
--[[

Task 2: Goal Parser

Submitted by: [66]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string, $str.

   Write a script to interpret the given string using Goal Parser.

     The Goal Parser interprets “G” as the string “G”, “()” as the string
     “o”, and “(al)” as the string “al”. The interpreted strings are then
     concatenated in the original order.

Example 1

Input: $str = "G()(al)"
Output: "Goal"

G    -> "G"
()   -> "o"
(al) -> "al"

Example 2

Input: $str = "G()()()()(al)"
Output: "Gooooal"

G       -> "G"
four () -> "oooo"
(al)    -> "al"

Example 3

Input: $str = "(al)G(al)()()"
Output: "alGaloo"

(al) -> "al"
G    -> "G"
(al) -> "al"
()   -> "o"
()   -> "o"

Example 4

Input: $str = "()G()G"
Output: "oGoG"

() -> "o"
G  -> "G"
() -> "o"
G  -> "G"

Example 5

Input: $str = "(al)(al)G()()"
Output: "alalGoo"

(al) -> "al"
(al) -> "al"
G    -> "G"
()   -> "o"
()   -> "o"
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 15th March
]]
--# solution by pokgopun@gmail.com

--@param string
local function goalParser(str) --@return string
	return str:gsub("(%((.-)%))", function(m1, m2)
		return m2 == "" and "o" or m2 == "al" and "al" or m1
	end)
end

local lu = require("luaunit")

function TestGoalParser()
	local data = {
		"G()(al)" , "Goal" ,
		"G()()()()(al)" , "Gooooal" ,
		"(al)G(al)()()" , "alGaloo" ,
		"()G()G" , "oGoG" ,
		"(al)(al)G()()" , "alalGoo",
	}
	for i=2, #data, 2 do
		local inpt, otpt = data[i-1], data[i]
		lu.assertEquals(goalParser(inpt), otpt)
	end
end

lu.run()
