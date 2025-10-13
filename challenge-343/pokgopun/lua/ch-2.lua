--# https://theweeklychallenge.org/blog/perl-weekly-challenge-343/
--[[

Task 2: Champion Team

Submitted by: [40]Mohammad Sajid Anwar
     __________________________________________________________________

   You have n teams in a tournament. A matrix grid tells you which team is
   stronger between any two teams:
If grid[i][j] == 1, then team i is stronger than team j
If grid[i][j] == 0, then team j is stronger than team i

   Find the champion team - the one with most wins, or if there is no
   single such team, the strongest of the teams with most wins. (You may
   assume that there is a definite answer.)

Example 1

Input: @grid = (
                 [0, 1, 1],
                 [0, 0, 1],
                 [0, 0, 0],
               )
Output: Team 0

[0, 1, 1] => Team 0 beats Team 1 and Team 2
[0, 0, 1] => Team 1 beats Team 2
[0, 0, 0] => Team 2 loses to all

Example 2

Input: @grid = (
                 [0, 1, 0, 0],
                 [0, 0, 0, 0],
                 [1, 1, 0, 0],
                 [1, 1, 1, 0],
               )
Output: Team 3

[0, 1, 0, 0] => Team 0 beats only Team 1
[0, 0, 0, 0] => Team 1 loses to all
[1, 1, 0, 0] => Team 2 beats Team 0 and Team 1
[1, 1, 1, 0] => Team 3 beats everyone

Example 3

Input: @grid = (
                 [0, 1, 0, 1],
                 [0, 0, 1, 1],
                 [1, 0, 0, 0],
                 [0, 0, 1, 0],
               )
Output: Team 0

[0, 1, 0, 1] => Team 0 beats teams 1 and 3
[0, 0, 1, 1] => Team 1 beats teams 2 and 3
[1, 0, 0, 0] => Team 2 beats team 0
[0, 0, 1, 0] => Team 3 beats team 2

Of the teams with 2 wins, Team 0 beats team 1.

Example 4

Input: @grid = (
                 [0, 1, 1],
                 [0, 0, 0],
                 [0, 1, 0],
               )
Output: Team 0

[0, 1, 1] => Team 0 beats Team 1 and Team 2
[0, 0, 0] => Team 1 loses to Team 2
[0, 1, 0] => Team 2 beats Team 1 but loses to Team 0

Example 5

Input: @grid = (
                 [0, 0, 0, 0, 0],
                 [1, 0, 0, 0, 0],
                 [1, 1, 0, 1, 1],
                 [1, 1, 0, 0, 0],
                 [1, 1, 0, 1, 0],
               )
Output: Team 2

[0, 0, 0, 0, 0] => Team 0 loses to all
[1, 0, 0, 0, 0] => Team 1 beats only Team 0
[1, 1, 0, 1, 1] => Team 2 beats everyone except self
[1, 1, 0, 0, 0] => Team 3 loses to Team 2
[1, 1, 0, 1, 0] => Team 4 loses to Team 2
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 19th October
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
--]]
--# solution by pokgopun@gmail.com

local function sum(nums)
	local sm = 0
	for _, v in ipairs(nums) do
		sm = sm + v
	end
	return sm
end

local function ct(grid)
	local mx, score = 0, {}
	for i, nums in ipairs(grid) do
		local sm = sum(nums)
		table.insert(score, sm)
		if mx < sm then
			mx = sm
		end
	end
	local top = {}
	for i, v in ipairs(score) do
		if v == mx then
			table.insert(top, i)
		end
	end
	local l = #top
	if l == 1 then
		return top[1] - 1   -- minus-one-offset as lua's collection start with index#1 while the challenge assumes more general index#0
	end
	for i=1, l-1 do
		for j=i+1, l do
			local a, b = top[i], top[j]
			if grid[a][b] == 1 then
				return a - 1   -- minus-one-offset as lua's collection start with index#1 while the challenge assumes more general index#0
			end
			if grid[b][a] == 1 then
				return b - 1   -- minus-one-offset as lua's collection start with index#1 while the challenge assumes more general index#0
			end
		end
	end
	return -1
end

local lu = require("luaunit")

function TestCt()
	for _, data in ipairs({
		{Input = {
		 {0, 1, 1},
                 {0, 0, 1},
                 {0, 0, 0}}, Output= 0},
		 {Input = {
                 {0, 1, 0, 0},
                 {0, 0, 0, 0},
                 {1, 1, 0, 0},
                 {1, 1, 1, 0}},Output= 3},
		 {Input = {
                 {0, 1, 0, 1},
                 {0, 0, 1, 1},
                 {1, 0, 0, 0},
                 {0, 0, 1, 0}},Output= 0},
		 {Input = {
                 {0, 1, 1},
                 {0, 0, 0},
                 {0, 1, 0}},Output= 0},
		 {Input = {
                 {0, 0, 0, 0, 0},
                 {1, 0, 0, 0, 0},
                 {1, 1, 0, 1, 1},
                 {1, 1, 0, 0, 0},
                 {1, 1, 0, 1, 0}},Output= 2}}) do
		 lu.assertEquals(ct(data.Input), data.Output)
	 end
 end

 lu.run()
