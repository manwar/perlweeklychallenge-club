--# https://theweeklychallenge.org/blog/perl-weekly-challenge-353/
--[[

Task 1: Max Words

Submitted by: [73]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of sentences.

   Write a script to return the maximum number of words that appear in a
   single sentence.

Example 1

Input: @sentences = ("Hello world", "This is a test", "Perl is great")
Output: 4

Example 2

Input: @sentences = ("Single")
Output: 1

Example 3

Input: @sentences = ("Short", "This sentence has six words in total", "A B C", "
Just four words here")
Output: 6

Example 4

Input: @sentences = ("One", "Two parts", "Three part phrase", "")
Output: 3

Example 5

Input: @sentences = ("The quick brown fox jumps over the lazy dog", "A", "She se
lls seashells by the seashore", "To be or not to be that is the question")
Output: 10

Task 2: Validate Coupon
--]]
--# solution by pokgopun@gmail.com

--@param sentences table
local function maxWords(sentences) --@return int
	local mx = 0
	for _, v in ipairs(sentences) do
		local c = 1
		for i=1,#v do
			if string.byte(v,i) == 32 then
				c = c + 1
			end
		end
		if mx < c then
			mx = c
		end
	end
	return mx
end

local lu = require("luaunit")

function TestMaxWords()
	for _, data in pairs({
		{Input = {"Hello world", "This is a test", "Perl is great"},Output= 4},
		{Input = {"Single"},Output= 1},
		{Input = {"Short", "This sentence has six words in total", "A B C", "Just four words here"},Output= 7},
		{Input = {"One", "Two parts", "Three part phrase", ""},Output= 3},
		{Input = {"The quick brown fox jumps over the lazy dog", "A", "She sells seashells by the seashore", "To be or not to be that is the question"},Output= 10}}) do
		lu.assertEquals(maxWords(data.Input), data.Output)
	end
end

lu.run()

