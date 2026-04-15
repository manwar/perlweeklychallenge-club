Perl Weekly Challenge 369
https://theweeklychallenge.org/blog/perl-weekly-challenge-369/

Task 1: Valid Tag
Submitted by: Mohammad Sajid Anwar
You are given a given a string caption for a video.

Write a script to generate tag for the given string caption in three steps as mentioned below:

1. Format as camelCase
Starting with a lower-case letter and capitalising the first letter of each subsequent word.
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
Input: $caption = "Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!"
Output: "#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn"

Task 2: Group Division
Submitted by: Mohammad Sajid Anwar
You are given a string, group size and filler character.

Write a script to divide the string into groups of given size. In the last group if the string doesn’t have enough characters remaining fill with the given filler character.

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
