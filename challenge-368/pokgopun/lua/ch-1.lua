--# https://theweeklychallenge.org/blog/perl-weekly-challenge-368/
--[[

Task 1: Make it Bigger

Submitted by: [62]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a given a string number and a character digit.

   Write a script to remove exactly one occurrence of the given character
   digit from the given string number, resulting the decimal form is
   maximised.

Example 1

Input: $str = "15456", $char = "5"
Output: "1546"

Removing the second "5" is better because the digit following it (6) is
greater than 5. In the first case, 5 was followed by 4 (a decrease),
which makes the resulting number smaller.

Example 2

Input: $str = "7332", $char = "3"
Output: "732"

Example 3

Input: $str = "2231", $char = "2"
Output: "231"

Removing either "2" results in the same string here. By removing a "2",
we allow the "3" to move up into a higher decimal place.

Example 4

Input: $str = "543251", $char = "5"
Output: "54321"

If we remove the first "5", the number starts with 4. If we remove the
second "5", the number still starts with 5. Keeping the largest possible
digit in the highest place value is almost always the priority.

Example 5

Input: $str = "1921", $char = "1"
Output: "921"

Task 2: Big and Little Omega
]]
--# solution by pokgopun@gmail.com

--@param string, string
local function mib(str, char) --@return string
	local cc = char:byte(1)
	local idx
	local l = #str
	local i = l
	while true do
		if i == 0 then
			break
		end
		local c = str:byte(i)
		if c == cc and (idx == nil or str:sub(i, i) < str:sub(i+1, i+1)) then
			idx = i
		end
		i = i - 1
	end
	if idx == nil then
		return str
	end
	return str:sub(1, idx-1)..str:sub(idx+1)
end

local lu = require("luaunit")

function TestMib()
	local data = {
		"15456", "5" , "1546" ,
		"7332", "3" , "732" ,
		"2231", "2" , "231" ,
		"543251", "5" , "54321" ,
		"1921", "1" , "921" ,
	}
	for i=3, #data, 3 do
		local str, char, otpt = data[i-2], data[i-1], data[i]
		lu.assertEquals(mib(str, char), otpt)
	end
end

lu.run()
