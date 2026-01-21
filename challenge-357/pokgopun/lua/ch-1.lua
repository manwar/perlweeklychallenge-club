--# https://theweeklychallenge.org/blog/perl-weekly-challenge-357/
--[[

Task 1: Kaprekar Constant

Submitted by: [43]Mohammad Sajid Anwar
     __________________________________________________________________

   Write a function that takes a 4-digit integer and returns how many
   iterations are required to reach Kaprekar’s constant (6174). For more
   information about Kaprekar's Constant please follow the [44]wikipedia
   page.

Example 1

Input: $int = 3524
Output: 3

Iteration 1: 5432 - 2345 = 3087
Iteration 2: 8730 - 0378 = 8352
Iteration 3: 8532 - 2358 = 6174

Example 2

Input: $int = 6174
Output: 0

Example 3

Input: $int = 9998
Output: 5

Iteration 1: 9998 - 8999 = 0999
Iteration 2: 9990 - 0999 = 8991
Iteration 3: 9981 - 1899 = 8082
Iteration 4: 8820 - 0288 = 8532
Iteration 5: 8532 - 2358 = 6174

Example 4

Input: $int = 1001
Output: 4

Iteration 1: 1100 - 0011 = 1089
Iteration 2: 9810 - 0189 = 9621
Iteration 3: 9621 - 1269 = 8352
Iteration 4: 8532 - 2358 = 6174

Example 5

Input: $int = 9000
Output: 4

Iteration 1: 9000 - 0009 = 8991
Iteration 2: 9981 - 1899 = 8082
Iteration 3: 8820 - 0288 = 8532
Iteration 4: 8532 - 2358 = 6174

Example 6

Input: $int = 1111
Output: -1

The sequence does not converge on 6174, so return -1.

Task 2: Unique Fraction Generator
--]]
--# solution by pokgopun@gmail.com

--@param int
local function kc(n) --@return int
	if n < 0 or n > 9999 then
		return nil
	end
	local c = 0
	while c <= 7 do
		if n == 6174 then
			break
		end
		local ints = {}
		while n > 0 do
			table.insert(ints, n % 10)
			n = n // 10
		end
		table.sort(ints)
		for i=1, 4 - #ints do
			table.insert(ints, 1, 0)
		end
		local j, t = #ints, 1
		for i=1, #ints do
			n = n + t*(ints[i] - ints[j])
			t = t * 10
			j = j - 1
		end
		if n == 0 then
			return -1
		end
		c = c + 1
		--print(n, c)
	end
	return c
end

local function fullTestSet() --@yield {int,ints}
	local counts, ints, d
	for n=0, 9999 do
		if n == 6174 then
			counts = {0}
		else
			counts = {-1}
			ints = {}
			d = n
			while d > 0 do
				table.insert(ints, d % 10)
				d = d // 10
			end
			table.sort(ints)
			for i=1, 4 - #ints do
				table.insert(ints, 1, 0)
			end
			for i=1, #ints-1 do
				if ints[i] ~= ints[i+1] then
					counts = {1,2,3,4,5,6,7}
					break
				end
			end
		end
		coroutine.yield(n, counts)
	end
end

--@param ints table, n int
local function contains(ints, n) --@return bool
	for _, v in ipairs(ints) do
		if v == n then
			return true
		end
	end
	return false
end

local lu = require("luaunit")

function TestKc()
	local data = {3524, 3, 6174, 0, 9998, 5, 1001, 4, 9000, 4, 1111, -1}
	for i=2, #data, 2 do
		local inpt, otpt = data[i-1], data[i]
		--print(inpt, "=>", otpt)
		lu.assertEquals(kc(inpt), otpt)
	end
	for n, counts in coroutine.wrap(function() fullTestSet() end) do
		--print(n, "=>", table.unpack(counts))
		lu.assertEquals(contains(counts, kc(n)), true)
	end
end

lu.run()
