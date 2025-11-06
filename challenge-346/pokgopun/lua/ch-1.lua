--# https://theweeklychallenge.org/blog/perl-weekly-challenge-346/
--[[

Task 1: Longest Parenthesis

Submitted by: [44]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string containing only ( and ).

   Write a script to find the length of the longest valid parenthesis.

Example 1

Input: $str = '(()())'
Output: 6

Valid Parenthesis: '(()())'

Example 2

Input: $str = ')()())'
Output: 4

Valid Parenthesis: '()()' at positions 1-4.

Example 3

Input: $str = '((()))()(((()'
Output: 8

Valid Parenthesis: '((()))()' at positions 0-7.

Example 4

Input: $str = '))))((()('
Output: 2

Valid Parenthesis: '()' at positions 6-7.

Example 5

Input: $str = '()(()'
Output: 2

Valid Parenthesis: '()' at positions 0-1 and 3-4.

Task 2: Magic Expression
--]]
--# solution by pokgopun@gmail.com

--@param string
local function lp(str) --@return int
	local p = {}
	for i=1, #str do
		p[i] = str:sub(i,i)
	end
	local c = 0
	local mx = 0
	for i=1, #str do
		--print(table.concat(p,""))
		if p[i] == "(" then
			c = c + 1
		else
			c = c - 1
			if c < 0 then
				c = 0
			else
				local j = i
				p[j] = "-"
				while p[j] ~= "(" do
					j = j - 1
				end
				p[j] = "-"
				while p[j] == "-" do
					j = j - 1
					if j < 1 then
						break
					end
				end
				local d = i - j
				if mx < d then
					mx = d
				end
			end
		end
	end
	--print(table.concat(p,""))
	return mx
end

local lu = require("luaunit")

function TestLp()
	for inpt, otpt in pairs({
		['(()())'] = 6,
		[')()())'] = 4,
		['((()))()(((()'] = 8,
		['))))((()('] = 2,
		['()(()'] = 2,
		['((()(()()'] = 4,
                ['((()(()())'] = 8,
                ['()(()()'] = 4,
                ['()(()())'] = 8}) do
		--print(inpt, otpt)
		lu.assertEquals(lp(inpt), otpt)
	end
end

lu.run()
