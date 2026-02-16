--# https://theweeklychallenge.org/blog/perl-weekly-challenge-361/
--[[

Task 2: Find Celebrity

Submitted by: [46]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a binary matrix (m x n).

   Write a script to find the celebrity, return -1 when none found.

     A celebrity is someone, everyone knows and knows nobody.

Example 1

Input: @party = (
            [0, 0, 0, 0, 1, 0],  # 0 knows 4
            [0, 0, 0, 0, 1, 0],  # 1 knows 4
            [0, 0, 0, 0, 1, 0],  # 2 knows 4
            [0, 0, 0, 0, 1, 0],  # 3 knows 4
            [0, 0, 0, 0, 0, 0],  # 4 knows NOBODY
            [0, 0, 0, 0, 1, 0],  # 5 knows 4
       );
Output: 4

Example 2

Input: @party = (
            [0, 1, 0, 0],  # 0 knows 1
            [0, 0, 1, 0],  # 1 knows 2
            [0, 0, 0, 1],  # 2 knows 3
            [1, 0, 0, 0]   # 3 knows 0
       );
Output: -1

Example 3

Input: @party = (
            [0, 0, 0, 0, 0],  # 0 knows NOBODY
            [1, 0, 0, 0, 0],  # 1 knows 0
            [1, 0, 0, 0, 0],  # 2 knows 0
            [1, 0, 0, 0, 0],  # 3 knows 0
            [1, 0, 0, 0, 0]   # 4 knows 0
       );
Output: 0

Example 4

Input: @party = (
            [0, 1, 0, 1, 0, 1],  # 0 knows 1, 3, 5
            [1, 0, 1, 1, 0, 0],  # 1 knows 0, 2, 3
            [0, 0, 0, 1, 1, 0],  # 2 knows 3, 4
            [0, 0, 0, 0, 0, 0],  # 3 knows NOBODY
            [0, 1, 0, 1, 0, 0],  # 4 knows 1, 3
            [1, 0, 1, 1, 0, 0]   # 5 knows 0, 2, 3
       );
Output: 3

Example 5

Input: @party = (
            [0, 1, 1, 0],  # 0 knows 1 and 2
            [1, 0, 1, 0],  # 1 knows 0 and 2
            [0, 0, 0, 0],  # 2 knows NOBODY
            [0, 0, 0, 0]   # 3 knows NOBODY
       );
Output: -1

Example 6

Input: @party = (
            [0, 0, 1, 1],  # 0 knows 2 and 3
            [1, 0, 0, 0],  # 1 knows 0
            [1, 1, 0, 1],  # 2 knows 0, 1 and 3
            [1, 1, 0, 0]   # 3 knows 0 and 1
      );
Output: -1
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 22nd February
   2026.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
--]]
--# solution by pokgopun@gmail.com
--@param table of ints
local function celeb(party) --@return int
	local l = #party
	local knowns = {}
	for i=1, l do
		table.insert(knowns, 0)
	end
	local cid = -1
	for r=1, l do
		local knows = 0
		for c=1, l do
			local k = party[r][c]
			knows = knows + k
			knowns[c] = knowns[c] + k
		end
		if knows == 0 and knowns[r] == r - 1 then
			cid = r - 1
		end
	end
	if cid >= 0 and knowns[cid + 1] ~= l - 1 then
		cid = -1
	end
	return cid
end

local lu = require("luaunit")

function TestCeleb()
	local data = {
		{
			{0, 0, 0, 0, 1, 0},  -- 0 knows 4
			{0, 0, 0, 0, 1, 0},  -- 1 knows 4
			{0, 0, 0, 0, 1, 0},  -- 2 knows 4
			{0, 0, 0, 0, 1, 0},  -- 3 knows 4
			{0, 0, 0, 0, 0, 0},  -- 4 knows NOBODY
			{0, 0, 0, 0, 1, 0},  -- 5 knows 4
		} , 4 ,
		{
			{0, 1, 0, 0},  -- 0 knows 1
			{0, 0, 1, 0},  -- 1 knows 2
			{0, 0, 0, 1},  -- 2 knows 3
			{1, 0, 0, 0},  -- 3 knows 0
		} , -1 ,
                {
			{0, 0, 0, 0, 0},  -- 0 knows NOBODY
			{1, 0, 0, 0, 0},  -- 1 knows 0
			{1, 0, 0, 0, 0},  -- 2 knows 0
			{1, 0, 0, 0, 0},  -- 3 knows 0
			{1, 0, 0, 0, 0},  -- 4 knows 0
		} , 0 ,
                {
			{0, 1, 0, 1, 0, 1},  -- 0 knows 1, 3, 5
			{1, 0, 1, 1, 0, 0},  -- 1 knows 0, 2, 3
			{0, 0, 0, 1, 1, 0},  -- 2 knows 3, 4
			{0, 0, 0, 0, 0, 0},  -- 3 knows NOBODY
			{0, 1, 0, 1, 0, 0},  -- 4 knows 1, 3
			{1, 0, 1, 1, 0, 0},  -- 5 knows 0, 2, 3
		} , 3 ,
                {
			{0, 1, 1, 0},  -- 0 knows 1 and 2
			{1, 0, 1, 0},  -- 1 knows 0 and 2
			{0, 0, 0, 0},  -- 2 knows NOBODY
			{0, 0, 0, 0},  -- 3 knows NOBODY
		} , -1 ,
		{
			{0, 0, 1, 1},  -- 0 knows 2 and 3
			{1, 0, 0, 0},  -- 1 knows 0
			{1, 1, 0, 1},  -- 2 knows 0, 1 and 3
			{1, 1, 0, 0},  -- 3 knows 0 and 1
		} , -1 ,
	}
	for i=2, #data, 2 do
		local inpt, otpt = data[i-1], data[i]
		lu.assertEquals(celeb(inpt), otpt)
	end
end

lu.run()
