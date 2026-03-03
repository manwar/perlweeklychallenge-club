--# https://theweeklychallenge.org/blog/perl-weekly-challenge-363/
--[[

Task 1: String Lie Detector

Submitted by: [52]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string.

   Write a script that parses a self-referential string and determines
   whether its claims about itself are true. The string will make
   statements about its own composition, specifically the number of vowels
   and consonants it contains.

Example 1

Input: $str = "aa — two vowels and zero consonants"
Output: true

Example 2

Input: $str = "iv — one vowel and one consonant"
Output: true

Example 3

Input: $str = "hello - three vowels and two consonants"
Output: false

Example 4

Input: $str = "aeiou — five vowels and zero consonants"
Output: true

Example 5

Input: $str = "aei — three vowels and zero consonants"
Output: true

Task 2: Subnet Sheriff
--]]
--# solution by pokgopun@gmail.com

local Processor = {
	["one"] =      1,
	["two"] =      2,
	["twen"] =     2,
	["three"] =    3,
	["thir"] =     3,
	["four"] =     4,
	["for"] =      4,
	["five"] =     5,
	["fif"] =      5,
	["six"] =      6,
	["seven"] =    7,
	["eight"] =    8,
	["eigh"] =     8,
	["nine"] =     9,
	["ten"] =      10,
	["eleven"] =   11,
	["twelve"] =   12,
	["hundred"] =  100,
	["thousand"] = 1000,
	["million"] =  1000000,
	["billion"] =  1000000000,
	["trillion"] = 1000000000000,
}

--@param string
function Processor:process(numstr) --@return int
	local sign, val = 1, 0
	local s = numstr:match("^minus (.+)")
	if s then
		sign = -1
		numstr = s
	end
	while true do
		local i = numstr:find(", ")
		if not i then
			break
		end
		val = val + self:process(numstr:sub(1,i-1))
		numstr = numstr:sub(i+2)
	end
	local i = numstr:find(" (.-)$")
	if i then
		local u = self[numstr:sub(i+1)]
		if u and u >= 100 then
			return sign * (val + u * self:process(numstr:sub(1, i-1)))
		end
	end
	while true do
		local i = numstr:find(" and ")
		if not i then
			break
		end
		val = val + self:process(numstr:sub(1,i-1))
		numstr = numstr:sub(i+5)
	end
	for v in string.gmatch(numstr.."-", "(.-)-") do
		local s, sfx = v:match("(.+)(t.-)$")
		if sfx == "ty" then
			val = val + 10 * self[s]
		elseif sfx == "teen" then
			val = val + 10 + self[s]
		else
			local n = self[v]
			if n then
				val = val + n
			end
		end
	end
	return sign * val
end

--@param string
local function sld(numstr) --@return bool
	local chars, vwl_cnt, csn_cnt= numstr:match("^(%S+) %S+ (%S+) vowels? and (%S+) consonants?$")
	chars = chars:lower()
	vwl_cnt = Processor:process(vwl_cnt)
	csn_cnt = Processor:process(csn_cnt)
	for v in chars:gmatch(".") do
		if ("aeiou"):find(v) then
			vwl_cnt = vwl_cnt - 1
		else
			csn_cnt = csn_cnt - 1
		end
	end
	return vwl_cnt == 0 and csn_cnt == 0
end

local lu = require("luaunit")

function TestSld()
	local data = {
		"aa — two vowels and zero consonants", true,
		"iv — one vowel and one consonant", true,
		"hello - three vowels and two consonants", false,
		"aeiou — five vowels and zero consonants", true,
		"aei — three vowels and zero consonants", true,
	}
	for i=2, #data, 2 do
		local inpt, otpt = data[i-1], data[i]
		lu.assertEquals(sld(inpt), otpt)
	end
end

lu.run()
