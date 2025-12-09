--# https://theweeklychallenge.org/blog/perl-weekly-challenge-351/
--[[

Task 1: Special Average

Submitted by: [55]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers.

   Write a script to return the average excluding the minimum and maximum
   of the given array.

Example 1

Input: @ints = (8000, 5000, 6000, 2000, 3000, 7000)
Output: 5250

Min: 2000
Max: 8000
Avg: (3000+5000+6000+7000)/4 = 21000/4 = 5250

Example 2

Input: @ints = (100_000, 80_000, 110_000, 90_000)
Output: 95_000

Min: 80_000
Max: 110_000
Avg: (100_000 + 90_000)/2 = 190_000/2 = 95_000

Example 3

Input: @ints = (2500, 2500, 2500, 2500)
Output: 0

Min: 2500
Max: 2500
Avg: 0

Example 4

Input: @ints = (2000)
Output: 0

Min: 2000
Max: 2000
Avg: 0

Example 5

Input: @ints = (1000, 2000, 3000, 4000, 5000, 6000)
Output: 3500

Min: 1000
Max: 6000
Avg: (2000 + 3000 + 4000 + 5000)/4 = 14000/4 = 3500

Task 2: Arithmetic Progression
--]]
--# solution by pokgopun@gmail.com

--@params ints table
local function sa(ints) --@return int
	local i = #ints
	if i < 3 then
		return 0
	end
	local mnmx = {ints[i]}
	local mn, mx, v
	local sm, n = 0, 0
	repeat
		i = i - 1
		v = ints[i]
		mn = mnmx[1]
		mx = mnmx[#mnmx]
		if mn == mx then
			if v < mn then
				table.insert(mnmx,1,v)
			else
				table.insert(mnmx,v)
			end
		else
			if v > mx then
				repeat
					sm = sm + table.remove(mnmx)
					n = n + 1
				until mnmx[#mnmx] < mx
				table.insert(mnmx,v)
			elseif v < mn then
				repeat
					sm = sm + table.remove(mnmx,1)
					n = n + 1
				until mnmx[1] > mn
				table.insert(mnmx,1,v)
			elseif  mn < v and v < mx then
				sm = sm + v
				n = n + 1
			else
				table.insert(mnmx, v == mn and 1 or #mnmx, v)
			end
		end
	until i == 1
	return sm == 0 and 0 or sm/n
end

local lu = require("luaunit")

function testSa()
	for _, data in ipairs({
		{ Input = {8000, 5000, 6000, 2000, 3000, 7000},Output= 5250},
		{Input = {100000, 80000, 110000, 90000},Output= 95000},
		{Input = {2500, 2500, 2500, 2500},Output= 0},
		{Input = {2000},Output= 0},
		{Input = {1000, 2000, 3000, 4000, 5000, 6000},Output= 3500}}) do
		--print(table.concat(data.Input," "), data.Output)
		lu.assertEquals(sa(data.Input),data.Output)
	end
end

lu.run()
