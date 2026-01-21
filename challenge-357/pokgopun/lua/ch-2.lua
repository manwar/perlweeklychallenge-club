--# https://theweeklychallenge.org/blog/perl-weekly-challenge-357/
--[[

Task 2: Unique Fraction Generator

Submitted by: Yary
     __________________________________________________________________

   Given a positive integer N, generate all unique fractions you can
   create using integers from 1 to N and follow the rules below:
- Use numbers 1 through N only (no zero)
- Create fractions like numerator/denominator
- List them in ascending order (from smallest to largest)
- If two fractions have the same value (like 1/2 and 2/4),
  only show the one with the smallest numerator

Example 1

Input: $int = 3
Output: 1/3, 1/2, 2/3, 1/1, 3/2, 2/1, 3/1

Example 2

Input: $int = 4
Output: 1/4, 1/3, 1/2, 2/3, 3/4, 1/1, 4/3, 3/2, 2/1, 3/1, 4/1

Example 3

Input: $int = 1
Output: 1/1

Example 4

Input: $int = 6
Output: 1/6, 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4,
        4/5, 5/6, 1/1, 6/5, 5/4, 4/3, 3/2, 5/3, 2/1,
        5/2, 3/1, 4/1, 5/1, 6/1

Example 5

Input: $int = 5
Output: 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 1/1,
        5/4, 4/3, 3/2, 5/3, 2/1, 5/2, 3/1, 4/1, 5/1
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 25th January
   2026.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
--]]
--# solution by pokgopun@gmail.com

--@param n int
local function ufc(n) --@return string
	local seen = {}
	local s = {}
	for i=1, n do
		for j=n, 1, -1 do
			if not seen[i/j] then
				seen[i/j] = true
				table.insert(s, {i, j})
			end
		end
	end
	table.sort(s, function(a, b) return a[1]/a[2] < b[1]/b[2] end)
	local out = ""
	for _, v in ipairs(s) do
		out = out..", "..string.format("%d/%d", v[1], v[2])
	end
	return string.sub(out,3)
end

local lu = require("luaunit")

function TestUfc()
	local data = {
		3, "1/3, 1/2, 2/3, 1/1, 3/2, 2/1, 3/1",
		4, "1/4, 1/3, 1/2, 2/3, 3/4, 1/1, 4/3, 3/2, 2/1, 3/1, 4/1",
		1, "1/1",
		6, "1/6, 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 5/6, 1/1, 6/5, 5/4, 4/3, 3/2, 5/3, 2/1, 5/2, 3/1, 4/1, 5/1, 6/1",
		5, "1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 1/1, 5/4, 4/3, 3/2, 5/3, 2/1, 5/2, 3/1, 4/1, 5/1",
	}
	for i=2, #data, 2 do
		local inpt, otpt = data[i-1], data[i]
		lu.assertEquals(ufc(inpt), otpt)
	end
end

lu.run()
