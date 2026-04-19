--# https://theweeklychallenge.org/blog/perl-weekly-challenge-369/
--[[

Task 1: Valid Tag

Submitted by: [63]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a given a string caption for a video.

   Write a script to generate tag for the given string caption in three
   steps as mentioned below:
1. Format as camelCase
Starting with a lower-case letter and capitalising the first letter of each subs
equent word.
Merge all words in the caption into a single string starting with a #.
2. Sanitise the String
Strip out all characters that are not English letters (a-z or A-Z).
3. Enforce Length
If the resulting string exceeds 100 characters, truncate it so it is
exactly 100 characters long.

Example 1

Input: $caption = "Cooking with 5 ingredients!"
Output: "#cookingWithIngredients"

Example 2

Input: $caption = "the-last-of-the-mohicans"
Output: "#thelastofthemohicans"

Example 3

Input: $caption = "  extra spaces here"
Output: "#extraSpacesHere"

Example 4

Input: $caption = "iPhone 15 Pro Max Review"
Output: "#iphoneProMaxReview"

Example 5

Input: $caption = "Ultimate 24-Hour Challenge: Living in a Smart Home controlled
 entirely by Artificial Intelligence and Voice Commands in the year 2026!"
Output: "#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialI
ntelligenceAndVoiceCommandsIn"

Task 2: Group Division
]]
--# solution by pokgopun@gmail.com

--@param string
local function validTag(caption) --@return string
	local out, l
	for v in caption:gmatch("%S+") do
		local s = v:gsub("%A", ""):lower()
		if out then
			s = s:gsub("^.", string.upper)
		else
			out = {"#"}
			l = 1
		end
		l = l + #s
		if l >= 100 then
			table.insert(out, s:sub(1, #s - l + 100))
			break
		end
		table.insert(out, s)
	end
	return table.concat(out)
end

local lu = require("luaunit")

function TestValidTag()
	local data = {
		"Cooking with 5 ingredients!" , "#cookingWithIngredients" ,
		"the-last-of-the-mohicans" , "#thelastofthemohicans" ,
		"  extra spaces here" , "#extraSpacesHere" ,
		"iPhone 15 Pro Max Review" , "#iphoneProMaxReview" ,
		"Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!" , "#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn",
	}
	for i=2, #data, 2 do
		local inpt, otpt = data[i-1], data[i]
		lu.assertEquals(validTag(inpt), otpt)
	end
end

lu.run()
